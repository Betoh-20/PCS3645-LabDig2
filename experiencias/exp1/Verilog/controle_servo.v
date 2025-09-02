/*
 * controle_servo.v - descrição comportamental
 *
 * controla um servomotor
 * ------------------------------------------------------------------------
 * Revisoes  :
 *     Data        Versao  Autor             Descricao
 *     02/09/2025  1.0     Andre Ito         criacao
 *                         Paulo Yamaguti
 *                         Roberto Hiraoka
 * ------------------------------------------------------------------------
 */

module controle_servo (
    input wire clock,
    input wire reset,
    input wire [1:0] posicao,
    output wire controle,
    output wire db_controle
);

// clock da FPGA: 50MHz, T = 20ns

circuito_pwm #(
    .conf_periodo (1000000), // f = 50 Hz, T = 20ms
    .largura_00   (0),       // T = 0ms
    .largura_01   (50000),   // T = 1ms
    .largura_10   (75000),   // T = 1.5ms
    .largura_11   (100000)  // T = 2ms
) pwm (
    .clock   (clock),
    .reset   (reset),
    .largura (posicao),
    .pwm     (controle),
    .db_pwm  (db_controle)
);

endmodule