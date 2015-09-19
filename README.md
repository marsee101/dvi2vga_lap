# dvi2vga_lap
Digilent社のZYBOボードを使用します。
http://www.digilentinc.com/Products/Detail.cfm?NavPath=2,400,1198&Prod=ZYBO

ZYBOのHDMI入力から入力した1280x720 60Pの画像をリアルタイムにラプラシアンフィルタ処理してVGA端子に出力します。

まずは”ZYBOのHDMI入力をVGA出力に出力する9（プロジェクトの公開）”を参照して Vivdo 2015.2 で dvi2vga_lap プロジェクトを作製してビットストリームの生成まで行って下さい。

http://marsee101.blog19.fc2.com/blog-entry-3255.html

ZYBOを使用したテスト手順を示します。
・ノートパソコンのHDMI端子からZYBOのHDMI端子に接続します。
・ZYBOのVGA端子からディスプレイに接続します。
・ZYBOの電源を入れます。
・Vivado でZYBOにビットストリームをコンフィグレーションします。

ノートパソコンのディスクトップ画面がZYBOに接続された画面に表示されます。
ZYBOのSW0を1にすると、ラプラシアンフィルタ処理が行われます。


We use Digilent Inc. ZYBO board.
http://www.digilentinc.com/Products/Detail.cfm?NavPath=2,400,1198&Prod=ZYBO

Please go to the generation of the bit stream First "the HDMI input of ZYBO (public project) 9 to be output to the VGA output" by reference to Vivdo 2015.2 by preparing the dvi2vga_lap project.
https://translate.google.co.jp/translate?sl=ja&tl=en&js=y&prev=_t&hl=ja&ie=UTF-8&u=http%3A%2F%2Fmarsee101.blog19.fc2.com%2Fblog-entry-3255.html&edit-text=&act=url

The 1280x720 60P image of input from the HDMI input of ZYBO in real time and then output to the VGA terminal by Laplacian filter processing.This is a project of Vivado 2015.2.

It shows the procedure.
· Connected to the HDMI terminal of ZYBO from laptop HDMI terminal.
· It was connected to a display from VGA terminal of ZYBO.
· Put the power of ZYBO.
· Configure the bit stream to ZYBO in Vivado.

Disk top screen of the notebook computer will be displayed on the screen that is connected to the ZYBO.
When the SW0 of ZYBO to 1, Laplacian filter processing is performed.

