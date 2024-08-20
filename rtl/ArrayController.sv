module ArrayController(
    input logic i_clk,
    input logic i_rst_n,

    // AXIS Slave interface
    input logic s_axis_valid,
    output logic s_axis_ready,

    // AXIS Master interface
    input logic m_axis_ready,
    output logic m_axis_valid,

    // Buffer interface
    input logic buff_is_empty, buff_is_full,
    output logic buff_rst_n,
    output logic buff_rd, buff_wr,

    // Array interface
    input logic arr_C_valid,
    output logic arr_rst_n

);


/* STATE MACHINE */
typedef enum {WAIT, FILL, PROCESS, OUT} states;

states PS, NS;

// sequential FSM logic
always_ff @(posedge i_clk) begin
    if (!i_rst_n) begin
        PS <= WAIT;
    end
    else begin
        PS <= NS;
    end
end

// NS and Out Decoder
always_comb begin
    m_axis_valid = 0;
    buff_rst_n = 1;
    buff_rd = 0;
    buff_wr = 0;
    arr_rst_n = 1;

    case (PS)
        WAIT: begin
            buff_rst_n = 0;
            arr_rst_n = 0;

            if (s_axis_valid && !buff_is_full) begin
                buff_wr = 1;
                buff_rst_n = 1;
                NS = FILL;
            end
            else NS = WAIT;
        end

        FILL: begin
            if (!buff_is_full && s_axis_valid) begin
                buff_wr = 1;
                NS = FILL;
            end
            else if (buff_is_full) begin
                arr_rst_n = 0;
                buff_wr = 0;

                NS = PROCESS;
            end
            else begin
                buff_wr = 0;
                NS = FILL;
            end


        end

        PROCESS: begin

            if (!arr_C_valid && !buff_is_empty) begin
                buff_rd = 1;
                NS = PROCESS;
            end
            else if (!arr_C_valid) begin
            	buff_rd = 0;
				NS = PROCESS;
            end
            else begin
            	buff_rd = 0;
				
                NS = OUT;
            end        
            
        end

        OUT: begin
            m_axis_valid = 1;
            buff_rd = 0;

            if (!m_axis_ready) begin
                NS = OUT;
            end
            else begin
				buff_rst_n = 0;
                NS = WAIT;
            end
        end

        default: NS = WAIT;

    endcase
end


assign s_axis_ready = !buff_is_full;   // memory ready to take data when it is not full


endmodule
