package loader_test

import (
	"os/exec"
	"testing"
)

func TestLoadVersions(t *testing.T) {
	cmd := exec.Command("git", "tag")
	o, err := cmd.Output()
	if err != nil {
		t.Fatal(err)
	}

	response := string(o)

	t.Log(len(response))
}
