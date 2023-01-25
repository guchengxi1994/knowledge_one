package main

import "C"

import (
	g "github.com/guchengxi1994/go_faker"
)

//export FakeAProfile
func FakeAProfile(gender bool) *C.char {
	f := g.Faker{
		Locale: "zh_CN",
	}
	f.AddParams("gender", gender, true)

	return C.CString(f.Profile(true))
}

func main() {
	// test: fmt.Printf("f.Profile(true): %v\n", FakeAProfile(true))

	// build: go build -buildmode=c-shared -o faker.dll .\main.go
}
