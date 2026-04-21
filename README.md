# PRODIGY_DS_04 - Sentiment Analysis on Twitter Data

## Task 04 - Prodigy InfoTech Data Science Internship

Analyze and visualize sentiment patterns in social media data to understand public opinion and attitudes towards specific topics or brands.

---

## Dataset

- **Source:** [Kaggle - Twitter Entity Sentiment Analysis](https://www.kaggle.com/datasets/jp797498e/twitter-entity-sentiment-analysis)
- **Files Used:** `twitter_training.csv` & `twitter_validation.csv`

---

## Tools & Libraries Used

- RStudio
- tidyverse
- tidytext
- wordcloud
- RColorBrewer
- scales

---

## What the Script Does

- Loads and combines training + validation data
- Cleans and filters irrelevant entries
- Analyzes sentiment distribution
- Identifies top entities by tweet count
- Visualizes sentiment proportion per entity
- Extracts most frequent words
- Generates Word Clouds for Positive & Negative sentiments
- Compares sentiment across top 5 entities

---

## Plots Generated

| Plot | Description |
|------|-------------|
| Bar Chart | Overall sentiment distribution |
| Pie Chart | Sentiment percentage breakdown |
| Bar Chart | Top 10 entities by tweet count |
| Stacked Bar | Sentiment proportion by entity |
| Bar Chart | Top 20 most frequent words |
| Word Cloud | Positive sentiment words |
| Word Cloud | Negative sentiment words |
| Grouped Bar | Sentiment count for top 5 entities |

---

## How to Run

1. Clone this repository
```bash
git clone https://github.com/YOUR_USERNAME/PRODIGY_DS_04.git
```
2. Download `twitter_training.csv` and `twitter_validation.csv` from the Kaggle link above
3. Place both files in the same folder as the script
4. Open `Task04_SentimentAnalysis.R` in RStudio
5. Run with `Ctrl + A` then `Ctrl + Enter`

---

## Author

Vedant Chaudhari
Data Science Intern — Prodigy InfoTech
