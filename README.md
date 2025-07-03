# 柏油宿舍校区

灵光一现写出来的东西，不知不觉规模就大到应该公开了。

欢迎大家一起来贡献内容。

排版比较复杂，数据全在 `.typ` 里放着，因为一开始就没好好写所以代码质量不是很高，请见谅。

## 获取

[WIP] 点击右侧 Releases 中最新版本下载。

## 构建

### 依赖

- [Typst](https://github.com/typst/typst) 0.13.1
- GNU Make
- 字体
  - 西文字体：[STIX Two Text](https://fonts.google.com/specimen/STIX+Two+Text)
  - 简体中文字体：[思源宋体 (Source Han Serif SC 2.003)](https://github.com/adobe-fonts/source-han-serif)
  - 等宽字体：[Fira Code Retina](https://github.com/tonsky/FiraCode)

### 编译

```bash
git clone git@github.com:ArtveFlinaInBupt/dormitory.git
cd dormitory
make
# 所有产物会在 `out/` 目录下
```

若需修改或二次创作，请自行阅读源码。

本项目采用 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) 协议。
