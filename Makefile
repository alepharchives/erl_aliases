ERL_SOURCES = erl_parse.erl erl_aliases.erl erl_aliases_tests.erl
TEST = erl_aliases

ERL = erl
ERLC = erlc
EBIN_DIR = $(PWD)
ERLC_FLAGS = -pa $(EBIN_DIR)

ERL_OBJECTS = $(ERL_SOURCES:%.erl=$(EBIN_DIR)/%.beam)

.PHONY: all test


all: $(ERL_OBJECTS) test


erl_aliases_tests.erl: erl_aliases.erl
	touch -r $< $@


%.beam: %.erl
	$(ERLC) $(ERLC_FLAGS) -o $(EBIN_DIR) $<


%.erl: %.yrl
	$(ERLC) $(ERLC_FLAGS) -o $(EBIN_DIR) $<


test: $(ERL_OBJECTS)
	$(ERL) -pa . -I . -noshell -s eunit test erl_aliases -s erlang halt #init stop


clean:
	rm -f $(ERL_OBJECTS) erl_crash.dump

