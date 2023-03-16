import nltk

nltk.download('vader-lexicon')

from nltk.sentiment.vader import SentimentIntensityAnalyzer

sia = SentimentIntensityAnalyzer()

text = """Reliance Industries (RIL) has shifted most of its oil traders from Mumbai to Dubai, executing a plan announced in 2021, but which now coincides with the city’s growing stature as a commodities hub after Russia’s war.
Most of the refiner’s oil procurement and trading are now conducted out of the UAE’s biggest city, said sources.
An RIL spokesperson declined to comment when contacted on the matter. India and China have become key consumers of discounted Russian crude after most others shunned the OPEC+ producer’s barrels following the invasion of Ukraine."""

targetCompany = "RIL"

sentences = nltk.sent_tokenize(text)
score = 0

print(sentences)

for sentence in sentences :
    print(sentence)
    if targetCompany in sentence :
        score += sia.polarity_scores(sentence)['compound']

print(score)

if score > 0: print("positive")
elif score < 0: print("negative")
else: print("neutral")
