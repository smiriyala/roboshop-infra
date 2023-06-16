#Notes: Makefile is a wrapper for shell command to be exuected
# ensure Makefile should start with 'M' capital
# And this file works on TAB indentation


git:
	git pull


# referring above git command as pre-req for dev-apply command.
# running aws-parameters as docdb username and pwd  must set in secrets. 
# then come out of it and run resource creation scripts.
## NOTE: cd .. doesnt work in makefile, we need to run cd and cmd together
dev-apply: git
	
	cd aws-parameters; terraform init -backend-config=env-dev/state.tfvars
	cd aws-parameters; terraform apply -auto-approve -var-file=env-dev/main.tfvars
	terraform init -backend-config=env-dev/state.tfvars
	terraform apply -auto-approve -var-file=env-dev/main.tfvars


# referring above git command as pre-req for dev-destroy command.
dev-destroy:
	terraform init -backend-config=env-dev/state.tfvars
	terraform destroy -auto-approve -var-file=env-dev/main.tfvars