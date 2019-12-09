# 変数

## ファイル名
md               := src/body.md                 # 本文
meta             := src/metadata.yaml           # YAMLメタデータファイル
template_okuduke := src/template-okuduke.tex    # Pandoc: 奥付用テンプレート
okuduke          := ./okuduke.tex                 # 奥付用texファイル
pdf              := ./book.pdf                    # 出力

## Pandocのオプション
pandoc_options := -s
pandoc_options += -N
pandoc_options += -f markdown+raw_tex+east_asian_line_breaks
pandoc_options += --top-level-division=chapter
pandoc_options += --pdf-engine=lualatex

# ルール

### make pdf: 入稿用PDFを生成
.PHONY: pdf
pdf: $(pdf)
$(pdf): $(header) $(okuduke) $(meta) $(md)
	pandoc $(pandoc_options) -A $(okuduke) --metadata-file=$(meta) $(md) -o $@

### 奥付のtexファイルを生成
$(okuduke): $(meta) $(template_okuduke)
	pandoc -f markdown+raw_tex $(meta) --template=$(template_okuduke) -o $@

### make clean: 生成物を削除
.PHONY: clean
clean:
	rm -f $(pdf)
	rm -f $(okuduke)

