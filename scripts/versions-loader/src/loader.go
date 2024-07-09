package loader

import (
	"os"
	"os/exec"
	"strings"
)

func Load() error {
	versions, err := GetVersions()
	if err != nil {
		return err
	}

	err = SetVersions(versions)
	if err != nil {
		return err
	}

	return nil
}

func GetVersions() (map[string]string, error) {
	versions := make(map[string]string)

	cmd := exec.Command("git", "tag")
	o, err := cmd.Output()
	if err != nil {
		return nil, err
	}

	response := string(o)
	s := strings.Split(response, "\n")
	for _, v := range s {
		ss := strings.Trim(v, " \t")
		sv := strings.Split(ss, "/")
		ver := sv[len(sv)-1]
		ss = strings.Join(sv[:len(sv)-1], "_")

		if ver > strings.ToUpper(ss) {
			versions[strings.ToUpper(ss)] = ver
		}
	}

	return versions, nil
}

func SetVersions(vers map[string]string) error {
	content := ""

	for k, v := range vers {
		content += k + "=\"" + v + "\"\n"
	}

	file, err := os.Create("versions.tfvars")
	if err != nil {
		return err
	}

	defer file.Close()

	_, err = file.WriteString(content)
	if err != nil {
		return nil
	}

	return nil
}
