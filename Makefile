lang ?= en

ifeq ($(lang), en)
	name := BUPT-dormcamp-
	name1 := BUPT-dormitory-
	name2 := BUPT-campus-
else ifeq ($(lang), zh)
	name := 柏油宿舍校区
	name1 := 柏油宿舍
	name2 := 柏油校区
else
	$(error "Unsupported language: $(lang). Supported languages are 'en' and 'zh'.")
endif

date := $(shell date +%y%m%d)

src := main.typ
src1 := content/dormitory.typ
src2 := content/campus.typ

out_dir := out

target_pdf := $(out_dir)/$(name)$(date).pdf
target_png_1 := $(out_dir)/$(name1)$(date).png
target_png_2 := $(out_dir)/$(name2)$(date).png
target_svg_1 := $(out_dir)/$(name1)$(date).svg
target_svg_2 := $(out_dir)/$(name2)$(date).svg

COMPILE := typst compile --root . --input release=

all: pdf png svg

$(out_dir):
	mkdir -p $(out_dir)

pdf: $(out_dir)
	$(COMPILE) $(src) $(target_pdf)

png: $(out_dir)
	$(COMPILE) $(src1) $(target_png_1) --ppi 300
	$(COMPILE) $(src2) $(target_png_2) --ppi 300

svg: $(out_dir)
	$(COMPILE) $(src1) $(target_svg_1)
	$(COMPILE) $(src2) $(target_svg_2)

clean:
	rm -rf $(out_dir)

.PHONY: all pdf png svg clean
