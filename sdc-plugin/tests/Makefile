# counter, counter2, pll - test buffer and clock divider propagation
# set_false_path - test the set_false_path command
# set_max_delay - test the set_max_delay command

TESTS = counter \
	counter2 \
	pll \
	pll_div \
	pll_fbout_phase \
	pll_approx_equal \
	set_false_path \
	set_max_delay

.PHONY: $(TESTS)

counter_verify = $(call compare,counter,sdc) && $(call compare,counter,txt)
counter2_verify = $(call compare,counter2,sdc) && $(call compare,counter2,txt)
pll_verify = $(call compare,pll,sdc)
pll_div_verify = $(call compare,pll_div,sdc)
pll_fbout_phase_verify = $(call compare,pll_fbout_phase,sdc)
pll_approx_equal_verify = $(call compare,pll_approx_equal,sdc)
set_false_path_verify = $(call compare,set_false_path,sdc)
set_max_delay_verify = $(call compare,set_max_delay,sdc)

all: $(TESTS)
compare = diff $(1)/$(1).golden.$(2) $(1)/$(1).$(2)

define test_tpl =
$(1): $(1)/$(1).sdc
	$$($(1)_verify)
	RETVAL=$$$$? ; \
	if [ $$$$RETVAL -eq 0 ]; then \
		echo "$(1) PASS"; \
		true; \
	else \
		echo "$(1) FAIL"; \
		false; \
	fi

$(1)/$(1).sdc: $(1)/$(1).v
	cd $(1); \
	INPUT_SDC_FILE=$(1).input.sdc \
	OUTPUT_SDC_FILE=$(1).sdc \
	yosys -p "tcl $(1).tcl" -l yosys.log

endef

$(foreach test,$(TESTS),$(eval $(call test_tpl,$(test))))

clean:
	rm -rf $(foreach test,$(TESTS),$(test)/$(test).sdc $(test)/$(test).txt $(test)/yosys.log)
