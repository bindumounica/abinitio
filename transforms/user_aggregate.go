package main

import (
	"encoding/csv"
	"fmt"
	"os"
)

func main() {
	file, _ := os.Open("data/raw/user_events.csv")
	reader := csv.NewReader(file)
	records, _ := reader.ReadAll()

	counts := make(map[string]int)

	for i, row := range records {
		if i == 0 {
			continue
		}
		user := row[0]
		counts[user]++
	}
	os.MkdirAll("data/curated", 0755)
	out, _ := os.Create("data/curated/user_activity_summary.csv")
	writer := csv.NewWriter(out)
	writer.Write([]string{"user_id", "event_count"})

	for user, count := range counts {
		writer.Write([]string{user, fmt.Sprint(count)})
	}
	writer.Flush()
}
