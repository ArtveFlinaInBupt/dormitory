name := BUPT-dormcamp
name1 := BUPT-campus
name2 := BUPT-dormitory
date := $(shell date +%y%m%d)

src := content/main.typ
src1 := content/dormitory.typ
src2 := content/campus.typ

out_dir := out

target_pdf := $(out_dir)/$(name)-$(date).pdf
target_png_1 := $(out_dir)/$(name1)-$(date).png
target_png_2 := $(out_dir)/$(name2)-$(date).png
target_svg_1 := $(out_dir)/$(name1)-$(date).svg
target_svg_2 := $(out_dir)/$(name2)-$(date).svg

all: pdf png svg

$(out_dir):
	mkdir -p $(out_dir)

pdf: $(out_dir)
	typst compile $(src) $(target_pdf) --root .

png: $(out_dir)
	typst compile $(src1) $(target_png_1) --root . --ppi 300
	typst compile $(src2) $(target_png_2) --root . --ppi 300

svg: $(out_dir)
	typst compile $(src1) $(target_svg_1) --root .
	typst compile $(src2) $(target_svg_2) --root .

clean: $(out_dir)
	find $(out_dir) \
		-maxdepth 1 \
		! -name "$(notdir $(target_pdf))" \
		! -name "$(notdir $(target_png_1))" \
		! -name "$(notdir $(target_png_2))" \
		! -name "$(notdir $(target_svg_1))" \
		! -name "$(notdir $(target_svg_2))" \
		-type f \
		-print \
		-exec rm -f {} +

.PHONY: all pdf png svg clean
