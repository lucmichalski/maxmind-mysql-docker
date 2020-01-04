package main

import (
	"fmt"
	"github.com/oschwald/geoip2-golang"
	"log"
	"net"
)

func main() {
	db, err := geoip2.Open("/usr/local/share/GeoIP/GeoLite2-Country.mmdb")
	defer db.Close()
	Fatal(err, "db open failed")

	// If you are using strings that may be invalid, check that ip is not nil
	ip := net.ParseIP("194.90.188.185")
	record, err := db.City(ip)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Portuguese (BR) city name: %v\n", record.City.Names["he-IL"])
	if len(record.Subdivisions) > 0 {
		fmt.Printf("English subdivision name: %v\n", record.Subdivisions[0].Names["he"])
	}
	fmt.Printf("Russian country name: %v\n", record.Country.Names["he"])
	fmt.Printf("ISO country code: %v\n", record.Country.IsoCode)
	fmt.Printf("Time zone: %v\n", record.Location.TimeZone)
	fmt.Printf("Coordinates: %v, %v\n", record.Location.Latitude, record.Location.Longitude)
}

func Fatal(err error, msg string) {
	if err != nil {
		log.Fatalf("%s: %s", msg, err)
	}
}
