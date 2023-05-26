#Notes: Makefile is a wrapper for shell command to be exuected
# ensure Makefile should start with 'M' capital
# And this file works on TAB indentation


git:
	git pull


# referring above git command as pre-req for dev-apply command.
dev-apply: git
	terraform init -backend-config=env-dev/state.tfvars
	terraform apply -auto-approve -var-file=env-dev/dev.tfvars


# referring above git command as pre-req for dev-destroy command.
dev-destroy:
	terraform init -backend-config=env-dev/state.tfvars
	terraform destroy -auto-approve -var-file=env-dev/dev.tfvars