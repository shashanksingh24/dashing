deploy-common:
        @OC_ARGS="$$( echo "$(OC_ARGS)" | sed -e 's/--token=[^[:space:]]*/--token=<token>/' )"; \
        echo "oc $${OC_ARGS} rollout latest dc/$${APP}"; \
        oc $(OC_ARGS) rollout latest dc/$(APP); \
        time_until=$$(( $$( date '+%s' ) + 500 )); \
        echo -n "Waiting for oc to become ready: "; \
        until ( \
                ( set -e; oc $(OC_ARGS) rollout status dc/$(APP) | grep -qv "Waiting " )  \
                ) >/dev/null 2>&1; do \
          if [ $$time_until -lt $$( date '+%s' ) ]; then \
            echo "  Timed out!"; \
            echo "oc $${OC_ARGS} rollout status dc/$${APP} --watch=false"; \
            oc $(OC_ARGS) rollout status dc/$(APP) --watch=false; \
            echo "exit 1"; \
            exit 1; \
          fi; \
          echo -n '.'; \
          sleep 0.5; \
        done; \
        echo; \
        echo "oc $${OC_ARGS} rollout status dc/$${APP}"; \
        oc $(OC_ARGS) rollout status dc/$(APP); \
