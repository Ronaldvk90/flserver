install:
	@echo "Installing the freelancer server"
	docker compose up -d
install-debug:
	@echo "Debug installer"
	docker compose up
clean:
	@echo "removing the freelancer server"
	docker compose down

clean-all: checker

checker:
	@echo -n "Removing and cleaning all files, container and image. Are you sure you want to continue? (y/n) " && read ans && [ $${ans:-N} = y ]
	docker compose down
	docker volume rm flserver_flhome
	docker image rm flserver:1.3
.PHONY: clean check_clean
