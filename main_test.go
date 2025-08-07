package main

import (
	"fmt"
	"runtime"
	"testing"
)

func TestGetGreeting(t *testing.T) {
	expected := fmt.Sprintf("Hello from a Go app running on %s/%s!", runtime.GOOS, runtime.GOARCH)
	if got := getGreeting(); got != expected {
		t.Errorf("getGreeting() = %q, want %q", got, expected)
	}
}