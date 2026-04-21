library(tidyverse)
library(tidytext)
library(wordcloud)
library(RColorBrewer)
library(scales)
library(gridExtra)

train <- read.csv("C:/Users/Vedant/Desktop/Prodigy Tasks/Task 4/twitter_training.csv", header = FALSE, stringsAsFactors = FALSE)
val   <- read.csv("C:/Users/Vedant/Desktop/Prodigy Tasks/Task 4/twitter_validation.csv", header = FALSE, stringsAsFactors = FALSE)

colnames(train) <- c("ID", "Entity", "Sentiment", "Text")
colnames(val)   <- c("ID", "Entity", "Sentiment", "Text")

df <- rbind(train, val)

df <- df %>% filter(Sentiment != "Irrelevant", !is.na(Text), Text != "")
df$Sentiment <- factor(df$Sentiment, levels = c("Positive", "Negative", "Neutral"))

dim(df)
str(df)
summary(df)
head(df)

x11()
sent_count <- df %>% count(Sentiment)
ggplot(sent_count, aes(x = Sentiment, y = n, fill = Sentiment)) +
  geom_bar(stat = "identity", width = 0.5, color = "white") +
  geom_text(aes(label = n), vjust = -0.5, size = 5, fontface = "bold") +
  scale_fill_manual(values = c("Positive" = "#2ecc71", "Negative" = "#e74c3c", "Neutral" = "#3498db")) +
  labs(title = "Sentiment Distribution", x = NULL, y = "Count") +
  theme_minimal() +
  theme(legend.position = "none")

x11()
sent_pct <- df %>% count(Sentiment) %>% mutate(pct = paste0(round(n / sum(n) * 100, 1), "%"))
pie(sent_count$n,
    labels = paste(sent_count$Sentiment, sent_pct$pct, sep = "\n"),
    col = c("#2ecc71", "#e74c3c", "#3498db"),
    main = "Sentiment Distribution (%)")

x11()
top_entities <- df %>% count(Entity, sort = TRUE) %>% top_n(10)
ggplot(top_entities, aes(x = reorder(Entity, n), y = n, fill = n)) +
  geom_bar(stat = "identity", color = "white") +
  coord_flip() +
  scale_fill_viridis_c(option = "C") +
  labs(title = "Top 10 Entities by Tweet Count", x = "Entity", y = "Count") +
  theme_minimal() +
  theme(legend.position = "none")

x11()
entity_sent <- df %>%
  filter(Entity %in% top_entities$Entity) %>%
  count(Entity, Sentiment)
ggplot(entity_sent, aes(x = reorder(Entity, n), y = n, fill = Sentiment)) +
  geom_bar(stat = "identity", position = "fill", color = "white") +
  coord_flip() +
  scale_fill_manual(values = c("Positive" = "#2ecc71", "Negative" = "#e74c3c", "Neutral" = "#3498db")) +
  scale_y_continuous(labels = percent) +
  labs(title = "Sentiment Proportion by Entity", x = "Entity", y = "Proportion", fill = "Sentiment") +
  theme_minimal()

x11()
tokens <- df %>%
  unnest_tokens(word, Text) %>%
  anti_join(stop_words, by = "word") %>%
  filter(!str_detect(word, "^[0-9]+$"))

top_words <- tokens %>% count(word, sort = TRUE) %>% top_n(20)
ggplot(top_words, aes(x = reorder(word, n), y = n, fill = n)) +
  geom_bar(stat = "identity", color = "white") +
  coord_flip() +
  scale_fill_viridis_c(option = "B") +
  labs(title = "Top 20 Most Frequent Words", x = "Word", y = "Count") +
  theme_minimal() +
  theme(legend.position = "none")

x11()
pos_words <- tokens %>% filter(Sentiment == "Positive") %>% count(word, sort = TRUE) %>% top_n(100)
wordcloud(words = pos_words$word, freq = pos_words$n,
          min.freq = 2, max.words = 100,
          colors = brewer.pal(8, "Greens"),
          random.order = FALSE, scale = c(3, 0.5),
          main = "Positive Sentiment Word Cloud")
title("Positive Sentiment Word Cloud")

x11()
neg_words <- tokens %>% filter(Sentiment == "Negative") %>% count(word, sort = TRUE) %>% top_n(100)
wordcloud(words = neg_words$word, freq = neg_words$n,
          min.freq = 2, max.words = 100,
          colors = brewer.pal(8, "Reds"),
          random.order = FALSE, scale = c(3, 0.5))
title("Negative Sentiment Word Cloud")

x11()
sent_entity_top <- df %>%
  filter(Entity %in% top_entities$Entity[1:5]) %>%
  count(Entity, Sentiment)
ggplot(sent_entity_top, aes(x = Entity, y = n, fill = Sentiment)) +
  geom_bar(stat = "identity", position = "dodge", color = "white") +
  scale_fill_manual(values = c("Positive" = "#2ecc71", "Negative" = "#e74c3c", "Neutral" = "#3498db")) +
  labs(title = "Sentiment Count for Top 5 Entities", x = "Entity", y = "Count", fill = "Sentiment") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 20, hjust = 1))

cat("\n==============================\n")
cat("SENTIMENT SUMMARY\n")
cat("==============================\n")
cat("Total Tweets :", nrow(df), "\n")
print(df %>% count(Sentiment) %>% mutate(Percentage = round(n / sum(n) * 100, 1)))
cat("\nTop 5 Entities:\n")
print(top_entities %>% top_n(5))