module EITHER
  imports INT
  imports BOOL

  syntax Either ::= Left() | Right()
  syntax Bool ::= P( Either , Int ) [function]

  rule P(Left(),I) => true
    requires I >Int 0
  rule P(Right(),I) => true
    requires I >Int 0
  rule P(_E,I) => false
    requires I <=Int 0

  // for either-spec
  syntax KItem ::= run ( Either, Int ) | done ( Either )
  rule run(Left(),  _I) => done(Left())
  rule run(Right(), _I) => done(Right())

endmodule
