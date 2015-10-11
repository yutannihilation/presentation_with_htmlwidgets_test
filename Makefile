HTML_FILES := $(patsubst %.Rmd, %_isolides.html ,$(wildcard *.Rmd)) \
              $(patsubst %.Rmd, %_isolides_noselfcontained.html ,$(wildcard *.Rmd)) \
              $(patsubst %.Rmd, %_slidy.html ,$(wildcard *.Rmd)) \
              $(patsubst %.Rmd, %_slidy_noselfcontained.html ,$(wildcard *.Rmd))

CACHE_DIRS := $(patsubst %.Rmd, %_cache ,$(wildcard *.Rmd))

FIGURE_DIR := figures/

all: html

html: $(HTML_FILES)

%_isolides.html: %.Rmd
	R --slave -e "tryCatch( \
		rmarkdown::render('$<', output_file = '$@', encoding = 'UTF-8', \
			output_format = 'ioslides_presentation', output_options = list( \
				self_contained = TRUE, \
				keep_md = TRUE \
			) \
		), error = function(e) cat(e\$$message, file = '$@') \
	)"

%_isolides_noselfcontained.html: %.Rmd
	R --slave -e "tryCatch( \
		rmarkdown::render('$<', output_file = '$@', encoding = 'UTF-8', \
			output_format = 'ioslides_presentation', output_options = list( \
				self_contained = FALSE, \
				keep_md = TRUE \
			) \
		), error = function(e) cat(e\$$message, file = '$@') \
	)"

%_slidy.html: %.Rmd
	R --slave -e "tryCatch( \
		rmarkdown::render('$<', output_file = '$@', encoding = 'UTF-8', \
			output_format = 'slidy_presentation', output_options = list( \
				self_contained = TRUE, \
				keep_md = TRUE \
			) \
		), error = function(e) cat(e\$$message, file = '$@') \
	)"

%_slidy_noselfcontained.html: %.Rmd
	R --slave -e "tryCatch( \
		rmarkdown::render('$<', output_file = '$@', encoding = 'UTF-8', \
			output_format = 'slidy_presentation', output_options = list( \
				self_contained = FALSE, \
				keep_md = TRUE \
			) \
		), error = function(e) cat(e\$$message, file = '$@') \
	)"

.PHONY: clean
clean:
	$(RM) *.html *.md
	$(RM) -r *_cache/ *_files/
