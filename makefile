sync:
	@echo "====synchronize the .zshrc file===="
	@cp ~/.zshrc .
	@read_config
	@echo "publish success"
