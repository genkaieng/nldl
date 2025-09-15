# nldl

ニコニコ生放送を保存するシェルスクリプト。

放送タイトル、放送者名、日時をファイル名にして[streamlink](https://streamlink.github.io/)で生放送を保存する。<br>
ffmpegでmp4に変換も行っているので、ffmpegにも依存。

## Dependencies

- streamlink
- ffmpeg

## Usage

1. `git clone git@github.com:genkaieng/nldl.git`
2. .envにニコニコのセッションキーを保存する。
3. `./nldl.sh <生放送URL>`

### Tips

シンボリックリンクでパスを通す

```sh
ln -s "$(pwd)/nldl.sh" ~/.local/bin/nldl
```
