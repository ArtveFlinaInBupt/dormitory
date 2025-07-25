# 柏油宿舍校区

灵光一现写出来的东西，不知不觉规模就大到应该公开了。

欢迎大家一起来贡献内容。

排版比较复杂，数据全在 `.typ` 里放着，因为一开始就没好好写所以代码质量不是很高，请见谅。

## 获取

在 [Releases](https://github.com/ArtveFlinaInBupt/dormitory/releases) 中下载。

## 构建

### 依赖

- [Typst](https://github.com/typst/typst) 0.13.1
- GNU Make
- 字体
  - 简体中文字体：[思源宋体 (Source Han Serif SC)](https://github.com/adobe-fonts/source-han-serif)
  - 西文字体：[STIX Two Text](https://github.com/stipub/stixfonts)
  - 数学字体：[STIX Two Math](https://github.com/stipub/stixfonts)
  - 等宽字体：[Fira Code](https://github.com/tonsky/FiraCode)

### 编译

```bash
git clone git@github.com:ArtveFlinaInBupt/dormitory.git
cd dormitory
make lang=zh
# 所有产物会在 `out/` 目录下
```

### 可能的问题

- 预览水印成为不相关的文字
  - 参见 [typst/typst Issue #5428](https://github.com/typst/typst/issues/5428)
  - 该问题[已修复](https://github.com/typst/typst/issues/5428)，可以自行编译最新的 Typst in development 使用，或忍着静待 Typst 发布新版本。

- 为什么只用宋体？太细了看着不舒服！
  - 我们难以解决与思源黑体协调的美观的西文非衬线体的使用许可问题。若您有好的解决方案，欢迎在 Issues 中提出。

## 其他

若需修改或二次创作，请自行阅读源码。

本项目采用 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) 协议。
