package id

import (
	"crypto/rand"
	"encoding/hex"
	"fmt"
)

func Gen(namespace string, length int) string {
	bytes := make([]byte, length)
	_, err := rand.Read(bytes)
	if err != nil {
		panic(err)
	}
	if namespace == "" {
		return hex.EncodeToString(bytes)
	}
	return fmt.Sprintf("%s_%s", namespace, hex.EncodeToString(bytes))
}
