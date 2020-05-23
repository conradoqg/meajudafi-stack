templates_dir = ./templates
spec_dir = ./spec
spec = out.yml
flags = --freeze

templates = $(wildcard $(templates_dir)/*.template.yml)

.PHONY: all
all: compile
		
.PHONY: compile
compile: $(spec_dir) $(spec_dir)/.env $(spec_dir)/$(spec)

.PHONY: clean
clean:
	rm -f $(spec_dir)/.env $(spec_dir)/$(spec)	
	rmdir $(spec_dir)

.PHONY: install
install:
	kubectl apply -f $(spec_dir)/$(spec)

$(spec_dir): $(shell mkdir -p $(spec_dir))

$(spec_dir)/.env: $(shell env > $(spec_dir)/.env)

$(spec_dir)/$(spec): $(templates)
	kubetpl render $^ -o $@ -i $(spec_dir)/.env $(flags)