# nldl

ニコ生放送を保存するシェルスクリプト。

<sub><strong>※内部では[streamlink](https://streamlink.github.io/)を呼んでるだけ。</strong></sub>

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
