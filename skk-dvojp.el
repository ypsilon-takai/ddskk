;;; skk-dvojp.el --- $B3HD%%m!<%^;zF~NO(B "DvorakJP" $B$r(B SKK $B$G;H$&$?$a$N@_Dj(B -*- coding: iso-2022-jp -*-

;; Copyright (C) 2013 TAKAI Yosiyuki <ypsilon.takai@gmail.com>

;; Author: TAKAI Yosiyuki <ypsilon.takai@gmail.com>
;; Maintainer: SKK Development Team <skk@ring.gr.jp>
;; Keywords: japanese, mule, input method
;; Created: Jan 2013

;; This file is part of Daredevil SKK.

;; Daredevil SKK is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.

;; Daredevil SKK is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Daredevil SKK, see the file COPYING.  If not, write to
;; the Free Software Foundation Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.


;;; Commentary:
;;
;; dvorak $BG[Ns$G$N3HD%%m!<%^;zF~NO(B "DvorakJP (Ver. 1.0)" $B$r(B SKK $B$G;H$&$?$a$N@_Dj$G$9!%(B
;; "DvorakJP" $B$K$D$$$F$O!$0J2<$N(B URL $B$r;2>H$7$F2<$5$$!%(B
;;   http://www7.plala.or.jp/dvorakjp/
;;
;; $B;H$$J}(B - $B2<5-$N@_Dj$r(B ~/.skk $B$K2C$($F$/$@$5$$!%(B
;;          $B$=$N8e(B Emacs(Mule) $B$r:F5/F0$9$l$P(B skk $B$K$h$k(B DvorakJP $B$G$N(B
;;          $BF~NO$,2DG=$G$9!%(B
;;
;;          (setq skk-use-dvojp t)
;;
;;         $B$^$?!"0J2<$N@_Dj$bF~$l$F$*$/$H!"$+9T$r(Bc$B$GF~$l$k>l9g$K!"<-=q$NAw$j2>L>$H$7$F(B
;;         $BG'<1$7$F$/$l$k$h$&$K$J$j$^$9!#(B
;;
;;         (setq skk-okuri-char-alist '((\"c\" . \"k\")))


;;; Code:

(eval-when-compile
  (require 'skk-macs)
  (require 'skk-vars))

(defvar skk-dvojp-additional-rom-kana-rule-list
  '(("q" nil skk-toggle-kana)
    ("Q" nil skk-set-henkan-point-subr)
    ;; $B$+9T$O(B c $B$r;H$&(B
    ("ca" nil ("$B%+(B" . "$B$+(B"))
    ("ci" nil ("$B%-(B" . "$B$-(B"))
    ("cu" nil ("$B%/(B" . "$B$/(B"))
    ("ce" nil ("$B%1(B" . "$B$1(B"))
    ("co" nil ("$B%3(B" . "$B$3(B"))
    ;; $BY92;!$Y{2;3HD%!$Fs=EJl2;3HD%(B
    ("cna" nil ("$B%-%c(B" . "$B$-$c(B"))
    ("cni" nil ("$B%-%#(B" . "$B$-$#(B"))
    ("cnu" nil ("$B%-%e(B" . "$B$-$e(B"))
    ("cne" nil ("$B%-%'(B" . "$B$-$'(B"))
    ("cno" nil ("$B%-%g(B" . "$B$-$g(B"))
    ("cha" nil ("$B%A%c(B" . "$B$A$c(B"))
    ("chi" nil ("$B%A%#(B" . "$B$A$#(B"))
    ("chu" nil ("$B%A%e(B" . "$B$A$e(B"))
    ("che" nil ("$B%A%'(B" . "$B$A$'(B"))
    ("cho" nil ("$B%A%g(B" . "$B$A$g(B"))
    ("kha" nil ("$B%-%c(B" . "$B$-$c(B"))
    ("khi" nil ("$B%-%#(B" . "$B$-$#(B"))
    ("khu" nil ("$B%-%e(B" . "$B$-$e(B"))
    ("khe" nil ("$B%-%'(B" . "$B$-$'(B"))
    ("kho" nil ("$B%-%g(B" . "$B$-$g(B"))
    ("kwa" nil ("$B%/%!(B" . "$B$/$!(B"))
    ("kwi" nil ("$B%/%#(B" . "$B$/$#(B"))
    ("kwe" nil ("$B%/%'(B" . "$B$/$'(B"))
    ("kwo" nil ("$B%/%)(B" . "$B$/$)(B"))
    ("sha" nil ("$B%7%c(B" . "$B$7$c(B"))
    ("shi" nil ("$B%7%#(B" . "$B$7$#(B"))
    ("shu" nil ("$B%7%e(B" . "$B$7$e(B"))
    ("she" nil ("$B%7%'(B" . "$B$7$'(B"))
    ("sho" nil ("$B%7%g(B" . "$B$7$g(B"))
    ("tna" nil ("$B%A%c(B" . "$B$A$c(B"))
    ("tni" nil ("$B%A%#(B" . "$B$A$#(B"))
    ("tnu" nil ("$B%A%e(B" . "$B$A$e(B"))
    ("tne" nil ("$B%A%'(B" . "$B$A$'(B"))
    ("tno" nil ("$B%A%g(B" . "$B$A$g(B"))
    ("tsa" nil ("$B%D%c(B" . "$B$D$c(B"))
    ("tsi" nil ("$B%D%#(B" . "$B$D$#(B"))
    ("tsu" nil ("$B%D(B" . "$B$D(B"))
    ("tse" nil ("$B%D%'(B" . "$B$D$'(B"))
    ("tso" nil ("$B%D%g(B" . "$B$D$g(B"))
    ("tha" nil ("$B%F%c(B" . "$B$F$c(B"))
    ("thi" nil ("$B%F%#(B" . "$B$F$#(B"))
    ("thu" nil ("$B%F%e(B" . "$B$F$e(B"))
    ("the" nil ("$B%F%'(B" . "$B$F$'(B"))
    ("tho" nil ("$B%F%g(B" . "$B$F$g(B"))
    ("nha" nil ("$B%K%c(B" . "$B$K$c(B"))
    ("nhi" nil ("$B%K%#(B" . "$B$K$#(B"))
    ("nhu" nil ("$B%K%e(B" . "$B$K$e(B"))
    ("nhe" nil ("$B%K%'(B" . "$B$K$'(B"))
    ("nho" nil ("$B%K%g(B" . "$B$K$g(B"))
    ("hna" nil ("$B%R%c(B" . "$B$R$c(B"))
    ("hni" nil ("$B%R%#(B" . "$B$R$#(B"))
    ("hnu" nil ("$B%R%e(B" . "$B$R$e(B"))
    ("hne" nil ("$B%R%'(B" . "$B$R$'(B"))
    ("hno" nil ("$B%R%g(B" . "$B$R$g(B"))
    ("fa" nil ("$B%U%!(B" . "$B$U$!(B"))
    ("fi" nil ("$B%U%#(B" . "$B$U$#(B"))
    ("fu" nil ("$B%U(B" . "$B$U(B"))
    ("fe" nil ("$B%U%'(B" . "$B$U$'(B"))
    ("fo" nil ("$B%U%)(B" . "$B$U$)(B"))
    ("fna" nil ("$B%U%c(B" . "$B$U$c(B"))
    ("fni" nil ("$B%U%#(B" . "$B$U$#(B"))
    ("fnu" nil ("$B%U%e(B" . "$B$U$e(B"))
    ("fne" nil ("$B%U%'(B" . "$B$U$'(B"))
    ("fno" nil ("$B%U%g(B" . "$B$U$g(B"))
    ("mna" nil ("$B%_%c(B" . "$B$_$c(B"))
    ("mni" nil ("$B%_%#(B" . "$B$_$#(B"))
    ("mnu" nil ("$B%_%e(B" . "$B$_$e(B"))
    ("mne" nil ("$B%_%'(B" . "$B$_$'(B"))
    ("mno" nil ("$B%_%g(B" . "$B$_$g(B"))
    ("rha" nil ("$B%j%c(B" . "$B$j$c(B"))
    ("rhi" nil ("$B%j%#(B" . "$B$j$#(B"))
    ("rhu" nil ("$B%j%e(B" . "$B$j$e(B"))
    ("rhe" nil ("$B%j%'(B" . "$B$j$'(B"))
    ("rho" nil ("$B%j%g(B" . "$B$j$g(B"))
    ("gna" nil ("$B%.%c(B" . "$B$.$c(B"))
    ("gni" nil ("$B%.%#(B" . "$B$.$#(B"))
    ("gnu" nil ("$B%.%e(B" . "$B$.$e(B"))
    ("gne" nil ("$B%.%'(B" . "$B$.$'(B"))
    ("gno" nil ("$B%.%g(B" . "$B$.$g(B"))
    ("gwa" nil ("$B%0%!(B" . "$B$0$!(B"))
    ("gwi" nil ("$B%0%#(B" . "$B$0$#(B"))
    ("gwe" nil ("$B%0%'(B" . "$B$0$'(B"))
    ("gwo" nil ("$B%0%)(B" . "$B$0$)(B"))
    ("zha" nil ("$B%8%c(B" . "$B$8$c(B"))
    ("zhi" nil ("$B%8%#(B" . "$B$8$#(B"))
    ("zhu" nil ("$B%8%e(B" . "$B$8$e(B"))
    ("zhe" nil ("$B%8%'(B" . "$B$8$'(B"))
    ("zho" nil ("$B%8%g(B" . "$B$8$g(B"))
    ("ja" nil ("$B%8%c(B" . "$B$8$c(B"))
    ("ji" nil ("$B%8(B" . "$B$8(B"))
    ("ju" nil ("$B%8%e(B" . "$B$8$e(B"))
    ("je" nil ("$B%8%'(B" . "$B$8$'(B"))
    ("jo" nil ("$B%8%g(B" . "$B$8$g(B"))
    ("dna" nil ("$B%B%c(B" . "$B$B$c(B"))
    ("dni" nil ("$B%B%#(B" . "$B$B$#(B"))
    ("dnu" nil ("$B%B%e(B" . "$B$B$e(B"))
    ("dne" nil ("$B%B%'(B" . "$B$B$'(B"))
    ("dno" nil ("$B%B%g(B" . "$B$B$g(B"))
    ("dha" nil ("$B%G%c(B" . "$B$G$c(B"))
    ("dhi" nil ("$B%G%#(B" . "$B$G$#(B"))
    ("dhu" nil ("$B%G%e(B" . "$B$G$e(B"))
    ("dhe" nil ("$B%G%'(B" . "$B$G$'(B"))
    ("dho" nil ("$B%G%g(B" . "$B$G$g(B"))
    ("bna" nil ("$B%S%c(B" . "$B$S$c(B"))
    ("bni" nil ("$B%S%#(B" . "$B$S$#(B"))
    ("bnu" nil ("$B%S%e(B" . "$B$S$e(B"))
    ("bne" nil ("$B%S%'(B" . "$B$S$'(B"))
    ("bno" nil ("$B%S%g(B" . "$B$S$g(B"))
    ("pna" nil ("$B%T%c(B" . "$B$T$c(B"))
    ("pni" nil ("$B%T%#(B" . "$B$T$#(B"))
    ("pnu" nil ("$B%T%e(B" . "$B$T$e(B"))
    ("pne" nil ("$B%T%'(B" . "$B$T$'(B"))
    ("pno" nil ("$B%T%g(B" . "$B$T$g(B"))
    ("va" nil ("$B%t%!(B" . "$B%t%!(B"))
    ("vi" nil ("$B%t%#(B" . "$B%t%#(B"))
    ("vu" nil ("$B%t(B" . "$B%t(B"))
    ("ve" nil ("$B%t%'(B" . "$B%t%'(B"))
    ("vo" nil ("$B%t%)(B" . "$B%t%)(B"))
    ("twu" nil ("$B%H%%(B" . "$B$H$%(B"))
    ("dwu" nil ("$B%I%%(B" . "$B$I$%(B"))
    ("xca" nil ("$B%u(B" . "$B%u(B"))
    ("xce" nil ("$B%v(B" . "$B%v(B"))
    ("xtu" nil ("$B%C(B" . "$B$C(B"))
    ;; $B@62;!$By2;!$Y{2;3HD%!$Fs=EJl2;3HD%(B
    ("c;" nil ("$B%+%s(B" . "$B$+$s(B"))
    ("cq" nil ("$B%3%s(B" . "$B$3$s(B"))
    ("cj" nil ("$B%1%s(B" . "$B$1$s(B"))
    ("ck" nil ("$B%/%s(B" . "$B$/$s(B"))
    ("cx" nil ("$B%-%s(B" . "$B$-$s(B"))
    ("s;" nil ("$B%5%s(B" . "$B$5$s(B"))
    ("sq" nil ("$B%=%s(B" . "$B$=$s(B"))
    ("sj" nil ("$B%;%s(B" . "$B$;$s(B"))
    ("sk" nil ("$B%9%s(B" . "$B$9$s(B"))
    ("sx" nil ("$B%7%s(B" . "$B$7$s(B"))
    ("t;" nil ("$B%?%s(B" . "$B$?$s(B"))
    ("tq" nil ("$B%H%s(B" . "$B$H$s(B"))
    ("tj" nil ("$B%F%s(B" . "$B$F$s(B"))
    ("tk" nil ("$B%D%s(B" . "$B$D$s(B"))
    ("tx" nil ("$B%A%s(B" . "$B$A$s(B"))
    ("n;" nil ("$B%J%s(B" . "$B$J$s(B"))
    ("nq" nil ("$B%N%s(B" . "$B$N$s(B"))
    ("nj" nil ("$B%M%s(B" . "$B$M$s(B"))
    ("nk" nil ("$B%L%s(B" . "$B$L$s(B"))
    ("nx" nil ("$B%K%s(B" . "$B$K$s(B"))
    ("h;" nil ("$B%O%s(B" . "$B$O$s(B"))
    ("hq" nil ("$B%[%s(B" . "$B$[$s(B"))
    ("hj" nil ("$B%X%s(B" . "$B$X$s(B"))
    ("hk" nil ("$B%U%s(B" . "$B$U$s(B"))
    ("hx" nil ("$B%R%s(B" . "$B$R$s(B"))
    ("m;" nil ("$B%^%s(B" . "$B$^$s(B"))
    ("mq" nil ("$B%b%s(B" . "$B$b$s(B"))
    ("mj" nil ("$B%a%s(B" . "$B$a$s(B"))
    ("mk" nil ("$B%`%s(B" . "$B$`$s(B"))
    ("mx" nil ("$B%_%s(B" . "$B$_$s(B"))
    ("r;" nil ("$B%i%s(B" . "$B$i$s(B"))
    ("rq" nil ("$B%m%s(B" . "$B$m$s(B"))
    ("rj" nil ("$B%l%s(B" . "$B$l$s(B"))
    ("rk" nil ("$B%k%s(B" . "$B$k$s(B"))
    ("rx" nil ("$B%j%s(B" . "$B$j$s(B"))
    ("g;" nil ("$B%,%s(B" . "$B$,$s(B"))
    ("gq" nil ("$B%4%s(B" . "$B$4$s(B"))
    ("gj" nil ("$B%2%s(B" . "$B$2$s(B"))
    ("gk" nil ("$B%0%s(B" . "$B$0$s(B"))
    ("gx" nil ("$B%.%s(B" . "$B$.$s(B"))
    ("z;" nil ("$B%6%s(B" . "$B$6$s(B"))
    ("zq" nil ("$B%>%s(B" . "$B$>$s(B"))
    ("zj" nil ("$B%<%s(B" . "$B$<$s(B"))
    ("zk" nil ("$B%:%s(B" . "$B$:$s(B"))
    ("zx" nil ("$B%8%s(B" . "$B$8$s(B"))
    ("d;" nil ("$B%@%s(B" . "$B$@$s(B"))
    ("dq" nil ("$B%I%s(B" . "$B$I$s(B"))
    ("dj" nil ("$B%G%s(B" . "$B$G$s(B"))
    ("dk" nil ("$B%E%s(B" . "$B$E$s(B"))
    ("dx" nil ("$B%B%s(B" . "$B$B$s(B"))
    ("b;" nil ("$B%P%s(B" . "$B$P$s(B"))
    ("bq" nil ("$B%\%s(B" . "$B$\$s(B"))
    ("bj" nil ("$B%Y%s(B" . "$B$Y$s(B"))
    ("bk" nil ("$B%V%s(B" . "$B$V$s(B"))
    ("bx" nil ("$B%S%s(B" . "$B$S$s(B"))
    ("cn;" nil ("$B%-%c%s(B" . "$B$-$c$s(B"))
    ("cnq" nil ("$B%-%g%s(B" . "$B$-$g$s(B"))
    ("cnj" nil ("$B%-%'%s(B" . "$B$-$'$s(B"))
    ("cnk" nil ("$B%-%e%s(B" . "$B$-$e$s(B"))
    ("cnx" nil ("$B%-%#%s(B" . "$B$-$#$s(B"))
    ("ky;" nil ("$B%-%c%s(B" . "$B$-$c$s(B"))
    ("kyq" nil ("$B%-%g%s(B" . "$B$-$g$s(B"))
    ("kyj" nil ("$B%-%'%s(B" . "$B$-$'$s(B"))
    ("kyk" nil ("$B%-%e%s(B" . "$B$-$e$s(B"))
    ("kyx" nil ("$B%-%#%s(B" . "$B$-$#$s(B"))
    ("sh;" nil ("$B%7%c%s(B" . "$B$7$c$s(B"))
    ("shq" nil ("$B%7%g%s(B" . "$B$7$g$s(B"))
    ("shj" nil ("$B%7%'%s(B" . "$B$7$'$s(B"))
    ("shk" nil ("$B%7%e%s(B" . "$B$7$e$s(B"))
    ("shx" nil ("$B%7%#%s(B" . "$B$7$#$s(B"))
    ("th;" nil ("$B%F%c%s(B" . "$B$F$c$s(B"))
    ("thq" nil ("$B%F%g%s(B" . "$B$F$g$s(B"))
    ("thj" nil ("$B%F%'%s(B" . "$B$F$'$s(B"))
    ("thk" nil ("$B%F%e%s(B" . "$B$F$e$s(B"))
    ("thx" nil ("$B%F%#%s(B" . "$B$F$#$s(B"))
    ("nh;" nil ("$B%K%c%s(B" . "$B$K$c$s(B"))
    ("nhq" nil ("$B%K%g%s(B" . "$B$K$g$s(B"))
    ("nhj" nil ("$B%K%'%s(B" . "$B$K$'$s(B"))
    ("nhk" nil ("$B%K%e%s(B" . "$B$K$e$s(B"))
    ("nhx" nil ("$B%K%#%s(B" . "$B$K$#$s(B"))
    ("hd;" nil ("$B%R%c%s(B" . "$B$R$c$s(B"))
    ("hdq" nil ("$B%R%g%s(B" . "$B$R$g$s(B"))
    ("hdj" nil ("$B%R%'%s(B" . "$B$R$'$s(B"))
    ("hdk" nil ("$B%R%e%s(B" . "$B$R$e$s(B"))
    ("hdx" nil ("$B%R%#%s(B" . "$B$R$#$s(B"))
    ("md;" nil ("$B%_%c%s(B" . "$B$_$c$s(B"))
    ("mdq" nil ("$B%_%g%s(B" . "$B$_$g$s(B"))
    ("mdj" nil ("$B%_%'%s(B" . "$B$_$'$s(B"))
    ("mdk" nil ("$B%_%e%s(B" . "$B$_$e$s(B"))
    ("mdx" nil ("$B%_%#%s(B" . "$B$_$#$s(B"))
    ("rh;" nil ("$B%j%c%s(B" . "$B$j$c$s(B"))
    ("rhq" nil ("$B%j%g%s(B" . "$B$j$g$s(B"))
    ("rhj" nil ("$B%j%'%s(B" . "$B$j$'$s(B"))
    ("rhk" nil ("$B%j%e%s(B" . "$B$j$e$s(B"))
    ("rhx" nil ("$B%j%#%s(B" . "$B$j$#$s(B"))
    ("gn;" nil ("$B%.%c%s(B" . "$B$.$c$s(B"))
    ("gnq" nil ("$B%.%g%s(B" . "$B$.$g$s(B"))
    ("gnj" nil ("$B%.%'%s(B" . "$B$.$'$s(B"))
    ("gnk" nil ("$B%.%e%s(B" . "$B$.$e$s(B"))
    ("gnx" nil ("$B%.%#%s(B" . "$B$.$#$s(B"))
    ("zh;" nil ("$B%8%c%s(B" . "$B$8$c$s(B"))
    ("zhq" nil ("$B%8%g%s(B" . "$B$8$g$s(B"))
    ("zhj" nil ("$B%8%'%s(B" . "$B$8$'$s(B"))
    ("zhk" nil ("$B%8%e%s(B" . "$B$8$e$s(B"))
    ("zhx" nil ("$B%8%#%s(B" . "$B$8$#$s(B"))
    ("dn;" nil ("$B%B%c%s(B" . "$B$B$c$s(B"))
    ("dnq" nil ("$B%B%g%s(B" . "$B$B$g$s(B"))
    ("dnj" nil ("$B%B%'%s(B" . "$B$B$'$s(B"))
    ("dnk" nil ("$B%B%e%s(B" . "$B$B$e$s(B"))
    ("dnx" nil ("$B%B%#%s(B" . "$B$B$#$s(B"))
    ("bn;" nil ("$B%S%c%s(B" . "$B$S$c$s(B"))
    ("bnq" nil ("$B%S%g%s(B" . "$B$S$g$s(B"))
    ("bnj" nil ("$B%S%'%s(B" . "$B$S$'$s(B"))
    ("bnk" nil ("$B%S%e%s(B" . "$B$S$e$s(B"))
    ("bnx" nil ("$B%S%#%s(B" . "$B$S$#$s(B"))
    ("ph;" nil ("$B%T%c%s(B" . "$B$T$c$s(B"))
    ("phq" nil ("$B%T%g%s(B" . "$B$T$g$s(B"))
    ("phj" nil ("$B%T%'%s(B" . "$B$T$'$s(B"))
    ("phk" nil ("$B%T%e%s(B" . "$B$T$e$s(B"))
    ("phx" nil ("$B%T%#%s(B" . "$B$T$#$s(B"))
    ("c'" nil ("$B%+%$(B" . "$B$+$$(B"))
    ("c," nil ("$B%3%&(B" . "$B$3$&(B"))
    ("c." nil ("$B%1%$(B" . "$B$1$$(B"))
    ("s'" nil ("$B%5%$(B" . "$B$5$$(B"))
    ("s," nil ("$B%=%&(B" . "$B$=$&(B"))
    ("s." nil ("$B%;%$(B" . "$B$;$$(B"))
    ("t'" nil ("$B%?%$(B" . "$B$?$$(B"))
    ("t," nil ("$B%H%&(B" . "$B$H$&(B"))
    ("t." nil ("$B%F%$(B" . "$B$F$$(B"))
    ("n'" nil ("$B%J%$(B" . "$B$J$$(B"))
    ("n," nil ("$B%N%&(B" . "$B$N$&(B"))
    ("n." nil ("$B%M%$(B" . "$B$M$$(B"))
    ("h'" nil ("$B%O%$(B" . "$B$O$$(B"))
    ("h," nil ("$B%[%&(B" . "$B$[$&(B"))
    ("h." nil ("$B%X%$(B" . "$B$X$$(B"))
    ("m'" nil ("$B%^%$(B" . "$B$^$$(B"))
    ("m," nil ("$B%b%&(B" . "$B$b$&(B"))
    ("m." nil ("$B%a%$(B" . "$B$a$$(B"))
    ("r'" nil ("$B%i%$(B" . "$B$i$$(B"))
    ("r," nil ("$B%m%&(B" . "$B$m$&(B"))
    ("r." nil ("$B%l%$(B" . "$B$l$$(B"))
    ("w'" nil ("$B%o%$(B" . "$B$o$$(B"))
    ("g'" nil ("$B%,%$(B" . "$B$,$$(B"))
    ("g," nil ("$B%4%&(B" . "$B$4$&(B"))
    ("g." nil ("$B%2%$(B" . "$B$2$$(B"))
    ("z'" nil ("$B%6%$(B" . "$B$6$$(B"))
    ("z," nil ("$B%>%&(B" . "$B$>$&(B"))
    ("z." nil ("$B%<%$(B" . "$B$<$$(B"))
    ("d'" nil ("$B%@%$(B" . "$B$@$$(B"))
    ("d," nil ("$B%I%&(B" . "$B$I$&(B"))
    ("d." nil ("$B%G%$(B" . "$B$G$$(B"))
    ("b'" nil ("$B%P%$(B" . "$B$P$$(B"))
    ("b," nil ("$B%\%&(B" . "$B$\$&(B"))
    ("b." nil ("$B%Y%$(B" . "$B$Y$$(B"))
    ("p'" nil ("$B%Q%$(B" . "$B$Q$$(B"))
    ("p," nil ("$B%]%&(B" . "$B$]$&(B"))
    ("p." nil ("$B%Z%$(B" . "$B$Z$$(B"))
    ("cn'" nil ("$B%-%c%$(B" . "$B$-$c$$(B"))
    ("cn," nil ("$B%-%g%&(B" . "$B$-$g$&(B"))
    ("cn." nil ("$B%-%'%$(B" . "$B$-$'$$(B"))
    ("ky'" nil ("$B%-%c%$(B" . "$B$-$c$$(B"))
    ("ky," nil ("$B%-%g%&(B" . "$B$-$g$&(B"))
    ("ky." nil ("$B%-%'%$(B" . "$B$-$'$$(B"))
    ("sh'" nil ("$B%7%c%$(B" . "$B$7$c$$(B"))
    ("sh," nil ("$B%7%g%&(B" . "$B$7$g$&(B"))
    ("sh." nil ("$B%7%'%$(B" . "$B$7$'$$(B"))
    ("th'" nil ("$B%F%c%$(B" . "$B$F$c$$(B"))
    ("th," nil ("$B%F%g%&(B" . "$B$F$g$&(B"))
    ("th." nil ("$B%F%'%$(B" . "$B$F$'$$(B"))
    ("nh'" nil ("$B%K%c%$(B" . "$B$K$c$$(B"))
    ("nh," nil ("$B%K%g%&(B" . "$B$K$g$&(B"))
    ("nh." nil ("$B%K%'%$(B" . "$B$K$'$$(B"))
    ("f'" nil ("$B%U%!%$(B" . "$B$U$!$$(B"))
    ("f," nil ("$B%U%)%&(B" . "$B$U$)$&(B"))
    ("f." nil ("$B%U%'%$(B" . "$B$U$'$$(B"))
    ("hn'" nil ("$B%R%c%$(B" . "$B$R$c$$(B"))
    ("hn," nil ("$B%R%g%&(B" . "$B$R$g$&(B"))
    ("hn." nil ("$B%R%'%$(B" . "$B$R$'$$(B"))
    ("mn'" nil ("$B%_%c%$(B" . "$B$_$c$$(B"))
    ("mn," nil ("$B%_%g%&(B" . "$B$_$g$&(B"))
    ("mn." nil ("$B%_%'%$(B" . "$B$_$'$$(B"))
    ("rh'" nil ("$B%j%c%$(B" . "$B$j$c$$(B"))
    ("rh," nil ("$B%j%g%&(B" . "$B$j$g$&(B"))
    ("rh." nil ("$B%j%'%$(B" . "$B$j$'$$(B"))
    ("gn'" nil ("$B%.%c%$(B" . "$B$.$c$$(B"))
    ("gn," nil ("$B%.%g%&(B" . "$B$.$g$&(B"))
    ("gn." nil ("$B%.%'%$(B" . "$B$.$'$$(B"))
    ("j'" nil ("$B%8%c%$(B" . "$B$8$c$$(B"))
    ("j," nil ("$B%8%g%&(B" . "$B$8$g$&(B"))
    ("j." nil ("$B%8%'%$(B" . "$B$8$'$$(B"))
    ("zh'" nil ("$B%8%c%$(B" . "$B$8$c$$(B"))
    ("zh," nil ("$B%8%g%&(B" . "$B$8$g$&(B"))
    ("zh." nil ("$B%8%'%$(B" . "$B$8$'$$(B"))
    ("dn'" nil ("$B%B%c%$(B" . "$B$B$c$$(B"))
    ("dn," nil ("$B%B%g%&(B" . "$B$B$g$&(B"))
    ("dn." nil ("$B%B%'%$(B" . "$B$B$'$$(B"))
    ("bn'" nil ("$B%S%c%$(B" . "$B$S$c$$(B"))
    ("bn," nil ("$B%S%g%&(B" . "$B$S$g$&(B"))
    ("bn." nil ("$B%S%'%$(B" . "$B$S$'$$(B"))
    ("ph'" nil ("$B%T%c%$(B" . "$B$T$c$$(B"))
    ("ph," nil ("$B%T%g%&(B" . "$B$T$g$&(B"))
    ("ph." nil ("$B%T%'%$(B" . "$B$T$'$$(B"))

;; " : $B$O(B ' ; $B$H$7$FJQ49$5$;$k(B
(setq skk-downcase-alist
      (append skk-downcase-alist '((?\" . ?\') (?: . ?\;))))

;; dvojp $BFCM-$NJQ495,B'$rDI2C$9$k(B
(dolist (rule skk-dvojp-additional-rom-kana-rule-list)
  (add-to-list 'skk-rom-kana-rule-list rule))

;; for jisx0201
(eval-after-load "skk-jisx0201"
  '(progn
     (dolist (rule skk-dvojp-additional-rom-kana-rule-list)
       (add-to-list 'skk-jisx0201-rule-list
		    (if (listp (nth 2 rule))
			(list (nth 0 rule) (nth 1 rule)
			      (japanese-hankaku (car (nth 2 rule))))
		      rule)))

     (setq skk-jisx0201-base-rule-tree
	   (skk-compile-rule-list skk-jisx0201-base-rule-list
				  skk-jisx0201-rule-list))))

(run-hooks 'skk-dvojp-load-hook)

(provide 'skk-dvojp)
;;; skk-dvojp.el ends here
