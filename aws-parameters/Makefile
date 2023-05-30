#Notes: Makefile is a wrapper for shell command to be exuected
# ensure Makefile should start with 'M' capital
# And this file works on TAB indentation


git:
	git pull

# referring above git command as pre-req for dev-apply command.
dev-params: git
	terraform init -backend-config=env-dev/state.tfvars
	terraform apply -auto-approve -var-file=env-dev/main.tfvars
