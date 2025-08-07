package main

import (
	"fmt"
	"runtime"
)

func getGreeting() string {
	return fmt.Sprintf("Hello from a Go app running on %s/%s!", runtime.GOOS, runtime.GOARCH)
}

func main() {
	fmt.Println(getGreeting())
}
