# LEMP-Vagrant

### 概要
centos6をインストールして、Nginx, Mysql, PHP, Xdebugなどのソフトウェアを整えます。

### 使い方

```
$ git clone git@github.com:ColdFreak/LEMP-Vagrant.git
$ cd LEMP-Vagrant
$ vagrant up
```

`vagrant up`を実行する前にWindowsにCygwinをインストールして、sshクライアントを入れるとcmdの使用を避けることができます。
Windowsプラットフォームで`vagrant up`コマンドで"仮想化支援機能(VT-x/AMD-V)を有効できません。"のようなエラーが出る場合
BIOSの設定が必要。下のリンクを参照してください
http://futurismo.biz/archives/1647

mysqlサーバーにtestdbを作成して，rootのパスワードを'rootpassword'に設定します．

Vagrantfile中のguiオプションはtrueになっているので，`vagrant up`コマンドでGUIが立ち上がります.GUI必要ないときにfalseに変更すればいいです．

