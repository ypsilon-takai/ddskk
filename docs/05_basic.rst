##############
基本的な使い方
##############

本章では、DDSKK の基本的な使用方法を説明します。これを読めば、とりあえず DDSKK を
使ってみるには充分です。

DDSKK を使った入力方法に慣れるには、付属の :ref:`チュートリアル <tutorial>` が最
適なので、お試しください。

なお、次章の「 :doc:`便利な応用機能 <06_apps>` 」は、興味のある個所のみをピックア
ップしてお読みになるのがいいでしょう。

**********
起動と終了
**********

.. index::
   pair: Function; skk-setup-modeline
   pair: Variable; mode-line-format

SKK モードに入るには :kbd:`C-x C-j` もしくは :kbd:`C-x j` とキー入力します。モー
ドラインの左端には、下記のように ``--かな:`` が追加されます [#]_ 。また、カーソル
の色が変化します。

.. code:: text

  --かな:MULE/7bit----- Buffer-name (Major-mode)---

再び :kbd:`C-x C-j` もしくは :kbd:`C-x j` をキー入力することで、SKK モードに入る
前のモードに戻り [#]_ 、カーソル色も元に戻ります。

.. el:defvar:: skk-status-indicator

  標準設定はシンボル 'left です。この変数をシンボル 'minor-mode と設定すれ
  ば、インジケータはモードラインのマイナーモードの位置に表示されます。

.. el:defvar:: skk-preload

  non-nil と設定することにより、DDSKK の初回起動を速くすることができます。

  .. code:: elisp

    (setq skk-preload t)

  .. note::

     ファイル :file:`~/.emacs.d/init.el` にて設定すること

  これは、SKK 本体プログラムの読み込みと、変数 :el:defvar:`skk-search-prog-list` に指定さ
  れた辞書の読み込みを Emacs の起動時に済ませてしまうことにより実現しています。

  そのため、Emacs の起動そのものは遅くなりますが、DDSKK を使い始めるときのレスポ
  ンスが軽快になります。

.. el:define-key:: M-x skk-restart

  SKK を再起動します。
  ファイル :file:`~/.skk` は再ロードしますが、ファイル :file:`~/.emacs.d/init.el` は
  再ロードしません。

.. el:define-key:: M-x skk-version

  と実行するとエコーエリアに SKK のバージョンを表示 [#]_ します。

  .. code:: text

    ----------- Echo Area -----------
    Daredevil SKK/16.2.50 (CODENAME)
    ----------- Echo Area -----------

SKK オートフィルモード
======================

.. index::
   keyword: オートフィル
   pair: Key; C-x j

:kbd:`C-x j` とキー入力すれば、SKK モードに入ると同時にオートフィルモードをオンに
します。

既にオートフィルモードがオンになっているバッファで :kbd:`C-x j` をキー入力すると、
オートフィルモードは逆にオフになるので注意してください。

.. index::
   pair: Key; M-1 C-x j
   pair: Key; C-u C-x j

バッファの状態にかかわらず強制的にオートフィルモード付で SKK モードに入りたい場合
は :kbd:`M-1 C-x j` や :kbd:`C-u C-x j` などとキー入力し、このコマンドに正の引数
を渡します。

.. index::
   keyword: 負の引数
   pair: Key; M-- C-x j
   pair: Key; C-u -1 C-x j

オートフィルモードをオフにし、かつ SKK モードも終了したい場合には
:kbd:`M-- C-x j` や :kbd:`C-u -1 C-x j` などとキー入力し、このコマンドに負の引数を
渡します。

- :infonode:`Auto Fill Mode in GNU Emacs Manual <(emacs)Auto Fill>`

- :infonode:`Arguments in GNU Emacs Manual <(emacs)Arguments>`

辞書の保存
==========

.. index::
   pair: Variable; skk-backup-jisyo
   pair: Variable; skk-jisyo

Emacs を終了するときは、保存前の個人辞書をファイル :file:`~/.skk-jisyo.BAK` に退避してから
:ref:`個人辞書 <jisyo-variant>` の内容をファイル :file:`~/.skk-jisyo` に保存 [#]_ します。

ファイル :file:`~/.skk-jisyo` やファイル :file:`~/.skk-jisyo.BAK` の名称を変更したければ、そ
れぞれ変数 :el:defvar:`skk-jisyo` や変数 :el:defvar:`skk-backup-jisyo` の値を変更して下さい。

.. el:define-key:: M-x skk-kill-emacs-without-saving-jisyo

  個人辞書を保存せずに Emacs を終了させたい場合には、このコマンドをキー入力します。

**********
入力モード
**********

SKK モードは、文字種類による４種類の **入力モード** と、辞書を用いた変換の状
態により３つの **変換モード** を持ちます。

入力モードの説明
================

.. list-table::

     * - モード名称
       - 説明
       - マイナーモードの表示
       - カーソル色
     * - かなモード
       - アスキー小文字をひらがなに変換するモード
       - かな
       - 赤系
     * - カナモード
       - アスキー小文字をカタカナに変換するモード
       - カナ
       - 緑系
     * - 全英モード
       - アスキー小文字／大文字を全角アルファベット [#]_ に変換するモード
       - 全英
       - 黄系
     * - アスキーモード
       - | 文字を変換しないモード。
         | 打鍵は :kbd:`C-j` を除いて通常の Emacs のコマンドとして解釈される。
       - SKK
       - 背景によりアイボリーかグレイ

:ref:`入力モードを示すカーソル色に関する設定 <cursor-color-input-mode>`

入力モードを切り替えるキー
==========================

.. list-table::

   * - Key
     - Bind
     - 説明
   * - :kbd:`q`
     - :el:defun:`skk-toggle-kana`
     - 「かなモード」と「カナモード」間をトグル切り替えする
   * - :kbd:`l`
     - :el:defun:`skk-latin-mode`
     - 「かなモード」又は「カナモード」から「アスキーモード」へ
   * - :kbd:`L`
     - :el:defun:`skk-jisx0208-latin-mode`
     - 「かなモード」又は「カナモード」から「全英モード」へ
   * - :kbd:`C-j`
     - :el:defun:`skk-kakutei`
     - 「アスキーモード」又は「全英モード」から「かなモード」へ

実際にはカナモードや全英モードで長時間入力を続けることはほとんどないので、かなモ
ードのままでカナ文字や全英文字を入力する便法が用意されています。

  - :ref:`かなモードからカタカナを入力 <input-katakana>`

  - :ref:`全英文字の入力 <input-zenei>`

.. el:defvar:: skk-show-mode-show

   Non-nil であれば、入力モードを切り替えたときに、入力モードをカーソル付近にも
   一瞬表示します。

.. el:define-key:: M-x skk-show-mode

   変数 :el:defvar:`skk-show-mode-show` の値をトグル切り替えします。  

.. el:defvar:: skk-show-mode-style

   標準設定は、シンボル 'inline です。
   シンボル 'tooltip を指定することも可能です。

.. el:defface:: skk-show-mode-inline-face

   シンボル 'inline 利用時の face です。

**********
変換モード
**********

変換モードは、次の３種類のいずれかです。

■モード（確定入力モード）
  あるキー入力に対応する文字列を、辞書を用いた文字変換を行わずに直接バッファへ入
  力するモード。

  入力モードに応じてローマ字からひらがなへ、ローマ字からカタカナへ、あるいはアス
  キー文字から全角アルファベットへ文字を変換する。

▽モード
  辞書変換の対象となる文字列「見出し語」を入力するモード

  ▽モードの変種として「SKK abbrev モード」があります。

▼モード
  見出し語について、辞書変換を行うモード

  ▼モードのサブモードとして :ref:`辞書登録モード <jisyo-register-mode>` があります。

■モード
========

.. index::
   keyword: 確定入力
   keyword: 確定入力モード
   keyword: ■モード

確定入力モードを「■モード」と呼びます。
■モードでは、あるキー入力に対応した特定の文字列への変換を行うだけで、辞書変換は
行いません。アスキー文字列から、入力モードに応じて、ひらがな、カタカナ、あるいは
全角アルファベットへ文字を変換します。カレントバッファにこのモード特有のマークは
表示されません。

.. index::
   keyword: ローマ字入力

かなモード、カナモードで、かつ ■モードである場合、標準設定の入力方法はいわゆるロ
ーマ字入力です。訓令式、ヘボン式のどちらによっても入力することができます。主な注
意点は以下のとおりです。

  - 「ん」 は ``n n`` 又は ``n '`` で入力する。
    直後に ``n`` 及び ``y`` 以外の子音が続くときは ``n`` だけで入力できる。

  - 促音は ``c h o t t o`` ⇒ 「ちょっと」 や ``m o p p a r a`` ⇒ 「もっぱら」
    のように次の子音を重ねて入力する。

  - 促音や拗音（ひらがなの小文字）を単独で入力するときは ``x a`` ⇒ 「ぁ」
    や ``x y a`` ⇒ 「ゃ」 などのように ``x`` を用いる。

  - 長音（ー）は ``-`` で入力する。

▽モード
========

.. index::
   keyword: ▽モード

▽モード では、辞書変換の対象となる文字列を入力します。
かなモードもしくはカナモードで、かつ■モードであるときに、
キー入力を **大文字で開始する** ことで▽モードに入ります。

.. code:: text

   K a n j i

     ------ Buffer: foo ------
     ▽かんじ*
     ------ Buffer: foo ------

:kbd:`K a n j i` のように打鍵することで▽モードに入り、続けて辞書変換の対象となる
文字列「見出し語」を入力します。▽マークは「▽モードである」という表示ですが、見
出し語の開始点を示す表示でもあります。

.. _after:

後から▽モードに入る方法
------------------------

.. index::
   pair: Key; Q

辞書変換の対象としたい文字列であったにも関わらず、先頭の文字を大文字で入力し忘れ
た場合は、その位置までポイントを戻してから :kbd:`Q` を打鍵することで、▽モードに
入ることができます。

.. code:: text

   k a n j i

     ------ Buffer: foo ------
     かんじ*
     ------ Buffer: foo ------

   C-u 3 C-b

     ------ Buffer: foo ------
     *かんじ
     ------ Buffer: foo ------

   Q

     ------ Buffer: foo ------
     ▽*かんじ
     ------ Buffer: foo ------

   C-e

     ------ Buffer: foo ------
     ▽かんじ*
     ------ Buffer: foo ------

「7がつ24にち」のように大文字から始めることができない文字列を見出し語としたい場合
は、 :kbd:`Q` を打鍵して▽モードにしてから「7がつ24にち」の文字列を入力します。

なお、▽モードでは、文字列の間に空白を含めることはできません。
これは、 :ref:`辞書エントリ <jisyo-entry>` の見出し語に空白を含めることができない
制限からきています。

- :infonode:`Point in GNU Emacs Manual <(emacs)Point>`

▽モードを抜ける方法
--------------------

.. index::
   pair: Key; C-j
   pair: Key; C-g

誤って▽モードに入ってしまったときは、次のどちらかの方法で復帰します。

  - :kbd:`C-j` を打鍵して、■モードに戻る
  - :kbd:`C-g` を打鍵して、見出し語を消去する

.. code:: text

   K a n j i

     ------ Buffer: foo ------
     ▽かんじ*
     ------ Buffer: foo ------

   C-j

     ------ Buffer: foo ------
     かんじ*
     ------ Buffer: foo ------

あるいは、

.. code:: text

   K a n j i

     ------ Buffer: foo ------
     ▽かんじ*
     ------ Buffer: foo ------

   C-g

     ------ Buffer: foo ------
     *
     ------ Buffer: foo ------

▼モード
========

.. index::
   keyword: ▼モード

▼モード では、▽モードで入力した見出し語を、辞書に従って変換する作業を行います。

▽モードで見出し語を入力した後に :kbd:`SPC` を打鍵することで▼モードに入ります。
▽マークから :kbd:`SPC` を打鍵したポイントまでの文字列が「見出し語」として確定さ
れ、検索されます。同時に、▽マークは▼マークで置き換えられます。

.. _no-okurigana:

送り仮名が無い場合
------------------

仮に、辞書に

.. code:: text

   かんじ /漢字/幹事/

という :ref:`エントリ <jisyo-entry>` が含まれるとして、以下に例を示します。

.. code:: text

   K a n j i

     ------ Buffer: foo ------
     ▽かんじ*
     ------ Buffer: foo ------

   SPC

     ------ Buffer: foo ------
     ▼漢字*
     ------ Buffer: foo ------

.. index::
   keyword: Overlays
   keyword: ハイライト
   keyword: 見出し語

この例では、▽モードにおける▽マークからポイントまでの間の文字列「かんじ」を辞書
変換の対象文字列（見出し語）として確定し、それについて辞書内での検索を行っていま
す。実際の変換動作では、候補部分がハイライト表示 [#]_ されます。

「漢字」が求める語であれば :kbd:`C-j` を打鍵してこの変換を確定します。
ハイライト表示も▼マークも消えます。

.. index::
   keyword: 暗黙の確定

また、 :kbd:`C-j` を打鍵せずに新たな確定入力を続けるか又は新たな変換を開始すると、
直前の変換は自動的に確定されます。これを :ref:`暗黙の確定 <ammoku-kakutei>` と呼
んでいます。打鍵することによる副作用として暗黙の確定を伴うキーは、印字可能な文字
全てと :kbd:`RET` です。

次候補・前候補
--------------

求める語がすぐに表示されなければ、更に続けて :kbd:`SPC` を打鍵することで次候補を
検索します。

.. code:: text

     ------ Buffer: foo ------
     ▼漢字*
     ------ Buffer: foo ------

   SPC

     ------ Buffer: foo ------
     ▼幹事*
     ------ Buffer: foo ------

候補が５つ以上あるときは、５番目以降の候補は７つずつまとめてエコーエリアに表示さ
れます。

例えば、辞書が

.. code:: text

   きょ /距/巨/居/裾/嘘/拒/拠/虚/挙/許/渠/据/去/

というエントリを含むときに :kbd:`K y o` の後に :kbd:`SPC` を５回 [#]_ 続けて打鍵すれ
ば

.. code:: text

   -------------------- Echo Area --------------------
   A:嘘  S:拒  D:拠  F:虚  J:挙  K:許  L:渠  [残り 2]
   -------------------- Echo Area --------------------

がエコーエリア [#]_ に表示されます。ここで仮に「許」を選択したければ :kbd:`k` を
打鍵します。

:kbd:`A` , :kbd:`S` , :kbd:`D` , :kbd:`F` , :kbd:`J` , :kbd:`K` , :kbd:`L` の各文
字は、押し易さを考慮してキーボードのホームポジションから横方向に一直線に配置され
ているキーが選ばれています。
また :ref:`候補の選択のために押すキー <cand-select-key>` は、大文字、小文字のいず
れでも構いません。

:kbd:`SPC` を連打してしまって求める候補を誤って通過してしまったときは :kbd:`x` を
打鍵 [#]_ すれば、前候補／前候補群に戻ることができます。

次々と候補を探しても求める語がなければ、自動的に :ref:`辞書登録モード <jisyo-register-mode>` に
なります（辞書登録モードは▼モードのサブモードです）。

.. el:defvar:: skk-previous-candidate-keys

  前候補／前候補群に戻る関数 :el:defun:`skk-previous-candidate` を割り当てるオブ
  ジェクトのリストを指定する。オブジェクトにはキーを表す文字列または event vector が
  指定できます。

  標準設定は :code:`(list "x" "\C-p")` です。

.. el:defvar:: skk-show-candidates-nth-henkan-char

  候補一覧を表示する関数 :el:defun:`skk-henkan-show-candidates` を呼び出すまで
  の変数 :el:defvar:`skk-start-henkan-char` を打鍵する回数。２以上の整数である必要。

.. el:defvar:: skk-henkan-number-to-display-candidates

  いちどに表示する候補の数。

.. _word-okuri:

送り仮名が有る場合
------------------

次に送り仮名のある単語について説明します。

「動く」を変換により求めたいときは :kbd:`U g o K u` のように、まず、▽モードに入
るために :kbd:`U` を大文字で入力し、次に、送り仮名の開始を DDSKK に教えるために
:kbd:`K` を大文字で入力します。

送り仮名の :kbd:`K` を打鍵した時点で▼モードに入って辞書変換が行われます（ :kbd:`SPC` 打鍵は要さない）。

送り仮名の入力時（ :ref:`ローマ字プレフィックス <roma-prefix>` が挿入された瞬間）
にプレフィックスの直前に一瞬だけ ``*`` が表示されることで送り仮名の開始時点を明示
します。プレフィックスに続くキー入力で、かな文字が完成した時点で ``*`` は消えます。

キー入力を分解して追いながらもう少し詳しく説明します。

.. code:: text

   U g o

     ------ Buffer: foo ------
     ▽うご*
     ------ Buffer: foo ------

   K

     ------ Buffer: foo ------
     ▽うご*k
     ------ Buffer: foo ------

   u

     ------ Buffer: foo ------
     ▼動く*
     ------ Buffer: foo ------

このように、DDSKK では送り仮名の開始地点をユーザが明示的に入力 [#]_ するので、シ
ステム側で送り仮名を分解する必要がありません。これにより、高速でヒット効率が高い
変換が可能になります。

ただし、サ変動詞の変換 [#]_ では、サ変動詞の語幹となる名詞
を **送りなし変換** [#]_ として変換し、その後「する」を■モードで入力した方が効率が
良くなります。

.. _jisyo-register-mode:

辞書登録モード
==============

.. index::
   keyword: 辞書登録

DDSKK には独立した辞書登録モードはありません。その代わり、辞書にない単語に関して
変換を行った場合に、自動的に辞書登録モードに入ります。例えば辞書に

.. code:: text

   へんかんちゅう /変換中/

のエントリがない場合に「変換中」を入力しようとして :kbd:`H e n k a n t y u u SPC`
とキー入力すると、下記のように、カレントバッファは▼モードのまま「へんかんちゅう」
に対して変換ができない状態で休止し、同時にミニバッファに「へんかんちゅう」という
プロンプトが表示されます。

.. code:: text

   ------ Buffer: foo ------
   ▼へんかんちゅう
   ------ Buffer: foo ------

.. code:: text

   ------ Minibuffer -------
   [辞書登録] へんかんちゅう: *
   ------ Minibuffer -------

.. note::

   もちろん、誤って登録してしまった単語を削除することができます。

     - :ref:`誤った登録の削除 <delete-wrong-register>`
     - :ref:`個人辞書ファイルの編集 <edit-jisyo>`

.. el:defvar:: skk-read-from-minibuffer-function

  この変数に「文字列を返す関数」を収めると、その文字列を辞書登録モードに入ったと
  きのプロンプトに初期表示します。関数 :el:defun:`read-from-minibuffer` の
  引数 ``INITIAL-CONTENTS`` に相当します。

  .. code:: elisp

     (setq skk-read-from-minibuffer-function
           (lambda () skk-henkan-key))

.. el:defface:: skk-jisyo-registration-badge-face

  変数 :el:defvar:`skk-show-inline` が non-nil であれば、辞書登録モードに移ったことを
  明示するためにカレントバッファに「↓辞書登録中↓」とインライン表示します。この
  「↓辞書登録中↓」に適用するフェイスです。

送り仮名が無い場合の辞書登録
----------------------------

辞書登録モードでは、キー入力はミニバッファに対して行われます。仮に辞書に

.. code:: text

   へんかん /変換/
   ちゅう /中/

のようなエントリがあるとして、ミニバッファで「変換中」の文字列を「変換」
と「中」とに分けて作ります。

.. code:: text

   H e n k a n SPC T y u u SPC

     ----------- Minibuffer ------------
     [辞書登録] へんかんちゅう: 変換▼中*
     ----------- Minibuffer ------------

ここで :kbd:`RET` を打鍵すれば「変換中」が :ref:`個人辞書 <jisyo-variant>` に登録
され、辞書登録モードは終了します [#]_ 。同時に、変換を行っているカレントバッファ
には「変換中」が挿入され確定されます。

辞書登録モードを抜けたいときは :kbd:`C-g` を打鍵するか、または何も登録せず :kbd:`RET` を
打鍵すると▽モードに戻ります。

送り仮名が有る場合の辞書登録
----------------------------

送り仮名のある単語の登録では、ミニバッファで作る候補に送り仮名そのものを登録しな
いように注意しなければいけません。仮に辞書に

.. code:: text

   うごk /動/

というエントリが無いとして、例を挙げて説明します。

.. code:: text

   U g o K u

     ------ Buffer: foo ------
     ▼うごく
     ------ Buffer: foo ------

     ------ Minibuffer -------
     [辞書登録] うご*く: *
     ------ Minibuffer -------

ミニバッファで辞書登録すべき文字列は「動」だけであり、送り仮名の「く」は含めては
いけません。「動く」と登録してしまうと、次に :kbd:`U g o K u` とキー入力したとき
に出力される候補が「動くく」になってしまいます。

.. code:: text

   D o u SPC

     ------ Minibuffer -------
     [辞書登録] うご*く: 動*
     ------ Minibuffer -------

   RET

     ------ Buffer: foo ------
     動く*
     ------ Buffer: foo ------

.. el:defvar:: skk-check-okurigana-on-touroku

  標準設定は nil です。 

  .. list-table::

     * - non-nil
       - 辞書登録時に送り仮名のチェックを行います。
     * - シンボル 'ask
       - ユーザに確認を求め、送り仮名と認められれば送り仮名を取り除いてから登録します。
     * - シンボル 'auto
       - ユーザに確認を求めず、勝手に送り仮名を判断して削除してから登録します。

.. _register-sahen:

サ変動詞の辞書登録に関する注意
------------------------------

サ変動詞（名詞の後に「する」を付けた形で構成される動詞）については「する」を送り
仮名とした送りあり変換 [#]_ をしないで、「運動」と「する」とに分けて入力すること
を前提としています [#]_ 。

例えば「運動する」は :kbd:`U n d o u SPC s u r u` とキー入力することにより入力で
きます。名詞から作られる形容詞等も同様です。

再帰的辞書登録
--------------

.. index::
   keyword: 再帰的辞書登録

ミニバッファを再帰的に使って辞書登録を再帰的に行うことができます。

仮に辞書に

.. code:: text

   さいきてき /再帰的/
   さいき /再帰/

のようなエントリがなく、かつ

.. code:: text

   さい /再/
   き /帰/
   てき /的/

のようなエントリがあるとします。

ここで :kbd:`S a i k i t e k i SPC` とキー入力すると、見出し語「さいきてき」に対
する候補を見つけられないので、ミニバッファに「さいきてき」というプロンプトを表示
して辞書登録モードに入ります。

「さいきてき」に対する辞書エントリを作るため :kbd:`S a i k i SPC` とキー入力する
と、更にこの候補も見つけられないので、ミニバッファに「さいき」というプロンプトを
表示して、再帰的に「さいき」の辞書登録モードに入ります。

:kbd:`S a i SPC K i SPC` とキー入力すると、ミニバッファは、

.. code:: text

   ------ Minibuffer -------
   [[辞書登録]] さいき: 再▼帰*
   ------ Minibuffer -------

となります。プロンプトが ``[ [ 辞書登録 ] ]`` となり ``[ ]`` がひとつ増えてい
ますが、この ``[ ]`` の数が再帰的な辞書登録モードの深さを表わしています。

ここで :kbd:`RET` を打鍵すると、個人辞書には

.. code:: text

   さいき /再帰/

というエントリが登録され、ミニバッファは「さいきてき」の辞書登録モードに戻り、プ
ロンプトは「さいきてき」となります。

今度は「再帰」が変換可能なので :kbd:`S a i k i SPC T e k i SPC` とキー入力すると、

.. code:: text

   ------ Minibuffer -------
   [辞書登録] さいきてき: 再帰▼的*
   ------ Minibuffer -------

となります。ここで :kbd:`RET` を打鍵することで「さいきてき」の辞書登録モードから
抜け、個人辞書に

.. code:: text

   さいきてき /再帰的/

というエントリが登録されます。カレントバッファのポイントには「再帰的」が挿入され
ます。

改行文字を含む辞書登録
----------------------

.. index::
   pair: Key; C-q C-j

改行文字を含む文字列を辞書に登録するには、辞書登録モードで改行文字を :kbd:`C-q C-j` に
より入力します。例えば、

.. code:: text

   〒980
   仙台市青葉区片平2-1-1
   東北大学電気通信研究所

を辞書に登録するには、辞書登録モードで、

.. code:: text

     〒980

     C-q C-j

     仙台市青葉区片平2-1-1

     C-q C-j

     東北大学電気通信研究所

と入力します。

.. _isearch:

************************
インクリメンタル・サーチ
************************

.. index::
   keyword: I-search
   keyword: Incremental search

DDSKK では、専用のインクリメンタル・サーチプログラムを Emacs 添付のファイル :file:`isearch.el` の
ラッパーとして実装しているため、日本語文字列のインクリメンタル・サーチをアスキー
文字と同様の操作で行うことができます。

skk-isearchの操作性
===================

大部分の動作は、Emacs オリジナルのインクリメンタル・サーチのままですから、
Emacs オリジナルのインクリメンタル・サーチのコマンド [#]_ やユーザ変数でのカスタ
マイズ [#]_ もそのまま利用できます。

インクリメンタル・サーチ中の入力方法は、通常のバッファにおける各入力モード、変換
モードでの入力方法と同一です。

.. index::
   pair: Key; C-r
   pair: Key; C-s
   pair: Key; M-C-s
   pair: Key; M-C-r

:kbd:`C-s` や :kbd:`C-r` あるいは :kbd:`M-C-s` や :kbd:`M-C-r` でインクリメンタル・
サーチを起動すると、インクリメンタル・サーチを起動したバッファの入力モードと同一
の入力モードで、キーとなる文字の入力が可能となります。

skk-isearch と入力モード
========================

入力モードに合わせて、インクリメンタル・サーチのプロンプトが表示されます。プロン
プトの種類は、以下の６つです。

.. list-table::
   
   * - I-search: [か]
     - かなモード
   * - I-search: [カ]
     - カナモード
   * - I-search: [英]
     - 全英モード
   * - I-search: [aa]
     - アスキーモード
   * - I-search: [aあ]
     - Abbrev モード
   * - I-search: [--]
     - | インクリメンタル・サーチモードで :kbd:`C-x C-j` など
       | を打鍵して DDSKK を終了した場合は、このプロンプト
       | が表示されます。

.. el:defvar:: skk-isearch-mode-string-alist

   プロンプトとして表示される文字列

.. _tutorial:

**************
チュートリアル
**************

.. index::
   pair: Key; M-x skk-tutorial

DDSKK には、基本的な操作方法を学習できるチュートリアルが附属しています。

日本語版チュートリアルは :kbd:`M-x skk-tutorial` で、
英語版チュートリアルは :kbd:`C-u M-x skk-tutorial RET English RET` で実行します。

.. el:defvar:: skk-tut-file

  チュートリアルファイルが標準の場所に置かれていない場合は、ファイル :file:`~/.emacs.d/init.el` で

  .. code:: elisp

     (setq skk-tut-file "/usr/local/share/skk/SKK.tut")

  と書くことにより、指定したチュートリアルファイルを使用させることができます。英
  語版のチュートリアルファイルは、 ``skk-tut-file`` に ``.E`` が付いたファイル名
  です。この場合であれば、ファイル :file:`/usr/local/share/skk/SKK.tut.E` になり
  ます。

.. el:defvar:: skk-tut-lang

  チュートリアルで用いる言語を文字列 ``Japanese`` 又は ``English`` で指定します。
  この変数よりも :kbd:`C-u M-x skk-tutorial` による言語指定が優先されます。

.. el:defvar:: skk-tut-use-face

  Non-nil であれば、チュートリアルで face を利用して表示します。

.. rubric:: 脚注

.. [#] ファイル :file:`skk.el` の関数 :el:defun:`skk-setup-modeline` にて、変数 :el:defvar:`mode-line-format` に
       変数 :el:defvar:`skk-icon` と変数 :el:defvar:`skk-modeline-input-mode` を追加しています。

.. [#] ただし、「アスキーモード」を利用すれば SKK モードから抜ける必要はほとんど
       ありません。

.. [#] :ref:`エラーなどの日本語表示 <display-japanese-message>`

.. [#] :ref:`個人辞書の保存動作 <saving-jisyo>`

.. [#] JIS X 0208 英字のこと。このマニュアルでは「全角アルファベット」と表記する。

.. [#] ハイライト表示は GNU Emacs の Overlays 機能を使用しています。

.. [#] 変数 :el:defvar:`skk-show-candidates-nth-henkan-char`

.. [#] エコーエリアとミニバッファは視覚的には同一の場所にありますが、エコーエリア
       が単にユーザへのメッセージを表示するのみであるのに対し、ミニバッファは独立
       したバッファとして機能する点が異なります。

.. [#] :kbd:`x` は小文字で入力する必要があります。

.. [#] :ref:`送り仮名の自動処理 <okurigana>`

.. [#] :ref:`サ変動詞の辞書登録に関する注意 <register-sahen>`

.. [#] :ref:`送り仮名が無い場合 <no-okurigana>`

.. [#] ここでは「暗黙の確定」が行われるので :kbd:`C-j` を打鍵する必要はありません。

.. [#] :ref:`送り仮名が有る場合 <word-okuri>`

.. [#] ファイル :file:`SKK-JISYO.L` など共有辞書のメンテナンス上、原則としてサ変
       動詞を「送りありエントリ」に追加していません。そのため、「する」を送り仮名
       とした送りあり変換では、辞書に候補がなく :ref:`辞書登録モード <jisyo-register-mode>` に
       入ってしまうので、名詞として分解して入力することが一般的です。

       ただし、DDSKK 13 以降では暫定的にサ変動詞の送りあり変換を可能にする機能を
       用意しました。 :ref:`サ変動詞変換 <sahen-dousi>`

.. [#] :kbd:`M-y` の関数 :el:defun:`isearch-yank-kill` 、
       :kbd:`M-p` の関数 :el:defun:`isearch-ring-retreat` 又は
       :kbd:`M-n` の関数 :el:defun:`isearch-ring-advance` など

       :infonode:`Incremental Search in GNU Emacs Manual <(emacs)Incremental Search>`

.. [#] 変数 :el:defvar:`search-highlight` など
