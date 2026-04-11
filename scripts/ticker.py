#!/usr/bin/env python

## Dependencies:
## python-yfinance

import json
import sys
import threading
import time

import yfinance as yf

# Instruments
symbols = [
    "ES=F",
    "NQ=F",
    "GC=F",
    "AAPL",
    "AMZN",
    "GOOGL",
    "MSFT",
    "NVDA",
    "TSLA",
    "BTC-USD",
]
cache = []


def fetch_data():
    """Fetches data every 5 minutes"""
    global cache
    while True:
        temp_cache = []
        for sym in symbols:
            try:
                ticker = yf.Ticker(sym)
                info = ticker.fast_info
                price = info["last_price"]
                prev_close = info["previous_close"]
                change = price - prev_close

                # Colors
                color = "#9ece61" if change >= 0 else "#f7768e"
                sign = "+" if change >= 0 else ""

                text = f"{sym}: {price:.2f} ({sign}{change:.2f})"
                temp_cache.append({"text": text, "color": color})
            except Exception:
                continue

        if temp_cache:
            cache = temp_cache

        time.sleep(300)  # in seconds = 5 minutes


threading.Thread(target=fetch_data, daemon=True).start()

while not cache:
    time.sleep(0.1)

# Waybar
# continous output loop
idx = 0
while True:
    current = cache[idx % len(cache)]
    output = {
        "text": f"<span color='{current['color']}'>{current['text']}</span>",
        "tooltip": "Live Ticker",
    }

    print(json.dumps(output))
    sys.stdout.flush()  # forces waybar to update

    idx += 1
    time.sleep(3)  # cycle to next instruments every 3 seconds
