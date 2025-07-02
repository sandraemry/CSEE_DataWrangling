---
title: (3) Clean your own data
nav: Application
---

## Let's apply our new skills!

Here's where we are going to use our shiny new skills to clean a messy data set. Feel free to use data from your own research, but if you don't have any yet you can either use `penguins_raw` and/or `messy_penguins`.

If you are using the raw version of the penguins data set, your goal will be to write reproducible code to transform the raw data into the processed data you see in the `penguins` data set. Are there additional columns that you feel like would be helpful to include here though? (*hint* maybe a binomial species name?)

For extra practice with validation, download this purposely messy `penguins` dataset and catch and fix the errors: 

<a href="content/data/messy_penguins.csv" download="messy_penguins.csv">
  <button>⬇️ Download messy_penguins.csv</button>
</a>


---------

### Options

Include code:

```{% raw %}
{% capture text %}
1. Use data from your own research.
2. Use data from your supervisor.
3. Transform `penguins_raw` to `penguins`.
4. Catch all the erros in the `messy_penguins` dataset. 
{% endcapture %}
{% include card.html text=text header="Skills Application" img="tidy_icecream.jpg" %}{% endraw %}
```
