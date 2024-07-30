package main

import (
	"testing"
	"time"

	"github.com/robinraju/snippetbox/internal/assert"
)

func TestHumanDate(t *testing.T) {
	tests := []struct {
		name string
		tm   time.Time
		want string
	}{
		{
			name: "UTC",
			tm:   time.Date(2024, 07, 22, 19, 43, 0, 0, time.UTC),
			want: "22 Jul 2024 at 19:43",
		},
		{
			name: "Empty",
			tm:   time.Time{},
			want: "",
		},
		{
			name: "CET",
			tm:   time.Date(2024, 07, 22, 19, 43, 0, 0, time.FixedZone("CET", 1*60*60)),
			want: "22 Jul 2024 at 18:43",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			hd := humanDate(tt.tm)

			assert.Equal(t, hd, tt.want)
		})
	}
}
