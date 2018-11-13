defmodule EltarWeb.LinkView do
  use EltarWeb, :view

  import Scrivener.HTML

  def seconds_ago(datetime) do
    NaiveDateTime.diff(NaiveDateTime.utc_now(),datetime)
  end


  def time_ago_in_words(seconds) when seconds < 60 do
    "#{seconds} seconds ago"
  end
  def time_ago_in_words(seconds) when seconds < 3600 do
    "#{round(seconds/60)} minutes ago"
  end
  def time_ago_in_words(seconds) when seconds < 86400 do
    "#{round(seconds/3600)} hours ago"
  end
  def time_ago_in_words(seconds) do
    "#{round(seconds/86400)} days ago"
  end
end
