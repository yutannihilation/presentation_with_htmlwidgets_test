HTML_FILES := $(patsubst %.Rmd, %_isolide.html ,$(wildcard *.Rmd)) \
              $(patsubst %.Rmd, %_isolide_noselfcontained.html ,$(wildcard *.Rmd))

CACHE_DIRS := $(patsubst %.Rmd, %_cache ,$(wildcard *.Rmd))

FIGURE_DIR := figures/

all: html

html: $(HTML_FILES)

%_isolide.html: %.Rmd
	R --slave -e "tryCatch( \
		rmarkdown::render('$<', output_file = '$@', encoding = 'UTF-8', \
			output_format = 'ioslides_presentation', output_options = list( \
				self_contained = TRUE, \
				keep_md = TRUE \
			) \
		), error = function(e) cat(e\$$message, file = '$@') \
	)"

%_isolide_noselfcontained.html: %.Rmd
	R --slave -e "tryCatch( \
		rmarkdown::render('$<', output_file = '$@', encoding = 'UTF-8', \
			output_format = 'ioslides_presentation', output_options = list( \
				self_contained = FALSE, \
				keep_md = TRUE \
			) \
		), error = function(e) cat(e\$$message, file = '$@') \
	)"

.PHONY: clean
clean:
	$(RM) *.html *.md
	$(RM) -r *_cache/ *_files/
