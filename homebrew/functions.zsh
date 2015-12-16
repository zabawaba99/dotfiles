function validate_formula() {
	set -x

	brew audit $@ --strict --online
	brew uninstall $@
	brew install --verbose --debug $@
	brew test $@
	brew tests
}