install:
	@echo "Installing the freelancer server"
	docker compose up -d
install-debug:
	@echo "Debug installer"
	docker compose up
clean:
	@echo "removing the freelancer server"
	docker compose down

clean-all:
	@echo -e Removing "\033[0;31m!!! AND CLEANING !!!\033[0m" all files
	docker compose down
	docker volume rm flserver_flhome
	docker image rm flserver:1.2
