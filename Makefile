parts = $(subst -, ,$(CIRCLE_USERNAME))
environment := $(shell echo "$(word 2,$(parts))" | tr '[:lower:]' '[:upper:]')
environments := PRODUCTION STAGING TEST

ifeq ($(filter $(environment),$(environments)),)
	export environment = DEVELOPMENT
endif

export appenv := $(shell echo "$(environment)" | tr '[:upper:]' '[:lower:]')
export TF_VAR_appenv := $(appenv)
export backend_bucket := grace-$(appenv)-config
export AWS_ACCESS_KEY_ID := $($(environment)_AWS_ACCESS_KEY_ID)
export AWS_SECRET_ACCESS_KEY := $($(environment)_AWS_SECRET_ACCESS_KEY)
export TF_VAR_sender := $($(environment)_SENDER)
export TF_VAR_recipients := $($(environment)_RECIPIENTS)
export TF_VAR_s3_bucket := grace-$(appenv)-logging
export TF_VAR_kms_key_arn := $($(environment)_KMS_KEY_ARN)

.PHONY: test deploy plan_terraform  apply_terraform
test: plan_terraform
deploy: test apply_terraform

plan_terraform:
		make -C terraform plan

apply_terraform:
		make -C terraform apply