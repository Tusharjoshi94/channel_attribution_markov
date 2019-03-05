# channel_attribution_markov
These days a user interacts and shuffles between multiple screens and channels on a daily basis. At one point a user may be scrolling through pictures on Instagram while in the next few minutes he/she is may be searching for something on Google. Users switch between the channels very quickly and this, in a way, creates a challenge for marketers to connect with them and target them at the right time for the right product/ services through the correct channel.  

There are different options for channel attribution modelling. First click model gives credit to the first interaction channel in the user journey whereas the last touch gives credit to last interacting channel also even credit is given by the linear model. These models are called as heuristic models as they use straightforward or specific approach while attributing a conversion or goal or destination to a particular channel.

Markov model is a unique model which takes a probabilistic approach while attributing conversion to channel.

How Markov Model Works ?
Markov Model gives 3 major results:
1. Transition Probability matrix
2. Removal effect
3. Channel Contribution
- Transition Probability matrix: Model calculates the probability of transition from one particular state in the user journey to a different state in the user journey. For example, if a user is starting the journey from Facebook and then using Organic Search lands on the lead page or final conversion page of a website, then Markov model calculates what are the chances or probability that a specific user is going to take the same path in future based on past data. Using the transition probability matrix, brands can estimate the future cost or spend on each channel.
- Removal effect: Based on the transition probability, Markov model calculates removal effect of each channel in the path which explains the %effect on leads or conversion if we remove a particular channel from the path.
- Channel Contribution: Unlike other attribution models, Markov model uses a probabilistic approach to give credit of each conversion to each channel. This is usually known as weighted imputation.

Weighted Imputation of Channel X=Total Conversions ×(Removal effect of channel X)/(Total Removal Effect of all channels) 
