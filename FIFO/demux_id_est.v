/* Generated by Yosys 0.7 (git sha1 61f6811, gcc 6.2.0-11ubuntu1 -O2 -fdebug-prefix-map=/build/yosys-OIL3SR/yosys-0.7=. -fstack-protector-strong -fPIC -Os) */

(* top =  1  *)
(* src = "demux_id_est.v:1" *)
module demux_id_est(Fifo_Data_out_est, clk, reset, valid_read_est, demux_to_VC0_est, demux_to_VC1_est, Fifo_wr0_est, Fifo_wr1_est);
  (* src = "demux_id_est.v:13" *)
  wire _00_;
  (* src = "demux_id_est.v:13" *)
  wire _01_;
  (* src = "demux_id_est.v:13" *)
  wire [5:0] _02_;
  (* src = "demux_id_est.v:13" *)
  wire [5:0] _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  wire _23_;
  wire _24_;
  wire _25_;
  wire _26_;
  wire _27_;
  wire _28_;
  wire _29_;
  wire _30_;
  wire _31_;
  (* src = "demux_id_est.v:3" *)
  input [5:0] Fifo_Data_out_est;
  (* src = "demux_id_est.v:9" *)
  output Fifo_wr0_est;
  (* src = "demux_id_est.v:10" *)
  output Fifo_wr1_est;
  (* src = "demux_id_est.v:4" *)
  input clk;
  (* src = "demux_id_est.v:7" *)
  output [5:0] demux_to_VC0_est;
  (* src = "demux_id_est.v:8" *)
  output [5:0] demux_to_VC1_est;
  (* src = "demux_id_est.v:5" *)
  input reset;
  (* src = "demux_id_est.v:6" *)
  input valid_read_est;
  NOT _32_ (
    .A(Fifo_Data_out_est[5]),
    .Y(_04_)
  );
  NOT _33_ (
    .A(reset),
    .Y(_05_)
  );
  NAND _34_ (
    .A(_05_),
    .B(valid_read_est),
    .Y(_06_)
  );
  NOR _35_ (
    .A(_06_),
    .B(_04_),
    .Y(_01_)
  );
  NAND _36_ (
    .A(_01_),
    .B(demux_to_VC0_est[0]),
    .Y(_07_)
  );
  NOR _37_ (
    .A(_06_),
    .B(Fifo_Data_out_est[5]),
    .Y(_00_)
  );
  NAND _38_ (
    .A(_00_),
    .B(Fifo_Data_out_est[0]),
    .Y(_08_)
  );
  NAND _39_ (
    .A(_08_),
    .B(_07_),
    .Y(_02_[0])
  );
  NAND _40_ (
    .A(_00_),
    .B(Fifo_Data_out_est[1]),
    .Y(_09_)
  );
  NAND _41_ (
    .A(_01_),
    .B(demux_to_VC0_est[1]),
    .Y(_10_)
  );
  NAND _42_ (
    .A(_10_),
    .B(_09_),
    .Y(_02_[1])
  );
  NAND _43_ (
    .A(_00_),
    .B(Fifo_Data_out_est[2]),
    .Y(_11_)
  );
  NAND _44_ (
    .A(_01_),
    .B(demux_to_VC0_est[2]),
    .Y(_12_)
  );
  NAND _45_ (
    .A(_12_),
    .B(_11_),
    .Y(_02_[2])
  );
  NAND _46_ (
    .A(_00_),
    .B(Fifo_Data_out_est[3]),
    .Y(_13_)
  );
  NAND _47_ (
    .A(_01_),
    .B(demux_to_VC0_est[3]),
    .Y(_14_)
  );
  NAND _48_ (
    .A(_14_),
    .B(_13_),
    .Y(_02_[3])
  );
  NAND _49_ (
    .A(_00_),
    .B(Fifo_Data_out_est[4]),
    .Y(_15_)
  );
  NAND _50_ (
    .A(_01_),
    .B(demux_to_VC0_est[4]),
    .Y(_16_)
  );
  NAND _51_ (
    .A(_16_),
    .B(_15_),
    .Y(_02_[4])
  );
  NOT _52_ (
    .A(demux_to_VC0_est[5]),
    .Y(_17_)
  );
  NOT _53_ (
    .A(valid_read_est),
    .Y(_18_)
  );
  NOR _54_ (
    .A(reset),
    .B(_18_),
    .Y(_19_)
  );
  NAND _55_ (
    .A(_19_),
    .B(Fifo_Data_out_est[5]),
    .Y(_20_)
  );
  NOR _56_ (
    .A(_20_),
    .B(_17_),
    .Y(_02_[5])
  );
  NAND _57_ (
    .A(_00_),
    .B(demux_to_VC1_est[0]),
    .Y(_21_)
  );
  NAND _58_ (
    .A(_01_),
    .B(Fifo_Data_out_est[0]),
    .Y(_22_)
  );
  NAND _59_ (
    .A(_22_),
    .B(_21_),
    .Y(_03_[0])
  );
  NAND _60_ (
    .A(_00_),
    .B(demux_to_VC1_est[1]),
    .Y(_23_)
  );
  NAND _61_ (
    .A(_01_),
    .B(Fifo_Data_out_est[1]),
    .Y(_24_)
  );
  NAND _62_ (
    .A(_24_),
    .B(_23_),
    .Y(_03_[1])
  );
  NAND _63_ (
    .A(_00_),
    .B(demux_to_VC1_est[2]),
    .Y(_25_)
  );
  NAND _64_ (
    .A(_01_),
    .B(Fifo_Data_out_est[2]),
    .Y(_26_)
  );
  NAND _65_ (
    .A(_26_),
    .B(_25_),
    .Y(_03_[2])
  );
  NAND _66_ (
    .A(_00_),
    .B(demux_to_VC1_est[3]),
    .Y(_27_)
  );
  NAND _67_ (
    .A(_01_),
    .B(Fifo_Data_out_est[3]),
    .Y(_28_)
  );
  NAND _68_ (
    .A(_28_),
    .B(_27_),
    .Y(_03_[3])
  );
  NAND _69_ (
    .A(_00_),
    .B(demux_to_VC1_est[4]),
    .Y(_29_)
  );
  NAND _70_ (
    .A(_01_),
    .B(Fifo_Data_out_est[4]),
    .Y(_30_)
  );
  NAND _71_ (
    .A(_30_),
    .B(_29_),
    .Y(_03_[4])
  );
  NOR _72_ (
    .A(demux_to_VC1_est[5]),
    .B(Fifo_Data_out_est[5]),
    .Y(_31_)
  );
  NOR _73_ (
    .A(_31_),
    .B(_06_),
    .Y(_03_[5])
  );
  DFF _74_ (
    .C(clk),
    .D(_02_[0]),
    .Q(demux_to_VC0_est[0])
  );
  DFF _75_ (
    .C(clk),
    .D(_02_[1]),
    .Q(demux_to_VC0_est[1])
  );
  DFF _76_ (
    .C(clk),
    .D(_02_[2]),
    .Q(demux_to_VC0_est[2])
  );
  DFF _77_ (
    .C(clk),
    .D(_02_[3]),
    .Q(demux_to_VC0_est[3])
  );
  DFF _78_ (
    .C(clk),
    .D(_02_[4]),
    .Q(demux_to_VC0_est[4])
  );
  DFF _79_ (
    .C(clk),
    .D(_02_[5]),
    .Q(demux_to_VC0_est[5])
  );
  DFF _80_ (
    .C(clk),
    .D(_03_[0]),
    .Q(demux_to_VC1_est[0])
  );
  DFF _81_ (
    .C(clk),
    .D(_03_[1]),
    .Q(demux_to_VC1_est[1])
  );
  DFF _82_ (
    .C(clk),
    .D(_03_[2]),
    .Q(demux_to_VC1_est[2])
  );
  DFF _83_ (
    .C(clk),
    .D(_03_[3]),
    .Q(demux_to_VC1_est[3])
  );
  DFF _84_ (
    .C(clk),
    .D(_03_[4]),
    .Q(demux_to_VC1_est[4])
  );
  DFF _85_ (
    .C(clk),
    .D(_03_[5]),
    .Q(demux_to_VC1_est[5])
  );
  DFF _86_ (
    .C(clk),
    .D(_00_),
    .Q(Fifo_wr0_est)
  );
  DFF _87_ (
    .C(clk),
    .D(_01_),
    .Q(Fifo_wr1_est)
  );
endmodule
