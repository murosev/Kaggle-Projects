{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "78d209ee",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2022-01-15T23:15:11.337643Z",
     "iopub.status.busy": "2022-01-15T23:15:11.334255Z",
     "iopub.status.idle": "2022-01-15T23:15:12.798895Z",
     "shell.execute_reply": "2022-01-15T23:15:12.797999Z"
    },
    "papermill": {
     "duration": 1.512437,
     "end_time": "2022-01-15T23:15:12.799075",
     "exception": false,
     "start_time": "2022-01-15T23:15:11.286638",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────── tidyverse 1.3.1 ──\n",
      "\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2\u001b[39m 3.3.5     \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 0.3.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.1.5     \u001b[32m✔\u001b[39m \u001b[34mdplyr  \u001b[39m 1.0.7\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.1.4     \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.4.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 2.0.2     \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.1\n",
      "\n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "'netflix-shows'"
      ],
      "text/latex": [
       "'netflix-shows'"
      ],
      "text/markdown": [
       "'netflix-shows'"
      ],
      "text/plain": [
       "[1] \"netflix-shows\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# This R environment comes with many helpful analytics packages installed\n",
    "# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n",
    "# For example, here's a helpful package to load\n",
    "\n",
    "library(tidyverse) # metapackage of all tidyverse packages\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "\n",
    "list.files(path = \"../input\")\n",
    "\n",
    "# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using \"Save & Run All\" \n",
    "# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current sessionb"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "aef980c3",
   "metadata": {
    "papermill": {
     "duration": 0.042739,
     "end_time": "2022-01-15T23:15:12.889323",
     "exception": false,
     "start_time": "2022-01-15T23:15:12.846584",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Questions to answer:\n",
    "\n",
    "1. What are the top 10 countries for TV Shows and what is their most frequent genre?\n",
    "2. What are the top 10 countries for movies and what is their most frequent director?\n",
    "3. Who are the top 5 most frequent actors on netflix?\n",
    "4. What is the longest running TV show?\n",
    "5. Which country has the most sum hours of movies?"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "d04df867",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-15T23:15:13.014422Z",
     "iopub.status.busy": "2022-01-15T23:15:12.978235Z",
     "iopub.status.idle": "2022-01-15T23:15:13.028065Z",
     "shell.execute_reply": "2022-01-15T23:15:13.026619Z"
    },
    "papermill": {
     "duration": 0.096432,
     "end_time": "2022-01-15T23:15:13.028247",
     "exception": false,
     "start_time": "2022-01-15T23:15:12.931815",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "library(tidyverse)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "7887c2eb",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-15T23:15:13.118653Z",
     "iopub.status.busy": "2022-01-15T23:15:13.117239Z",
     "iopub.status.idle": "2022-01-15T23:15:13.459381Z",
     "shell.execute_reply": "2022-01-15T23:15:13.457359Z"
    },
    "papermill": {
     "duration": 0.388645,
     "end_time": "2022-01-15T23:15:13.459546",
     "exception": false,
     "start_time": "2022-01-15T23:15:13.070901",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[1mRows: \u001b[1m\u001b[22m\u001b[34m\u001b[34m8807\u001b[34m\u001b[39m \u001b[1m\u001b[1mColumns: \u001b[1m\u001b[22m\u001b[34m\u001b[34m12\u001b[34m\u001b[39m\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1m\u001b[1mColumn specification\u001b[1m\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m (11): show_id, type, title, director, cast, country, date_added, rating,...\n",
      "\u001b[32mdbl\u001b[39m  (1): release_year\n",
      "\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use \u001b[30m\u001b[47m\u001b[30m\u001b[47m`spec()`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set \u001b[30m\u001b[47m\u001b[30m\u001b[47m`show_col_types = FALSE`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to quiet this message.\n",
      "\n"
     ]
    }
   ],
   "source": [
    "netflix <- read_csv(\"../input/netflix-shows/netflix_titles.csv\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "c3505911",
   "metadata": {
    "papermill": {
     "duration": 0.044675,
     "end_time": "2022-01-15T23:15:13.550100",
     "exception": false,
     "start_time": "2022-01-15T23:15:13.505425",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Quick glance at the data"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "4d7bfb78",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-15T23:15:13.647531Z",
     "iopub.status.busy": "2022-01-15T23:15:13.645450Z",
     "iopub.status.idle": "2022-01-15T23:15:13.677104Z",
     "shell.execute_reply": "2022-01-15T23:15:13.675321Z"
    },
    "papermill": {
     "duration": 0.08154,
     "end_time": "2022-01-15T23:15:13.677273",
     "exception": false,
     "start_time": "2022-01-15T23:15:13.595733",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   show_id              type              title             director        \n",
       " Length:8807        Length:8807        Length:8807        Length:8807       \n",
       " Class :character   Class :character   Class :character   Class :character  \n",
       " Mode  :character   Mode  :character   Mode  :character   Mode  :character  \n",
       "                                                                            \n",
       "                                                                            \n",
       "                                                                            \n",
       "     cast             country           date_added         release_year \n",
       " Length:8807        Length:8807        Length:8807        Min.   :1925  \n",
       " Class :character   Class :character   Class :character   1st Qu.:2013  \n",
       " Mode  :character   Mode  :character   Mode  :character   Median :2017  \n",
       "                                                          Mean   :2014  \n",
       "                                                          3rd Qu.:2019  \n",
       "                                                          Max.   :2021  \n",
       "    rating            duration          listed_in         description       \n",
       " Length:8807        Length:8807        Length:8807        Length:8807       \n",
       " Class :character   Class :character   Class :character   Class :character  \n",
       " Mode  :character   Mode  :character   Mode  :character   Mode  :character  \n",
       "                                                                            \n",
       "                                                                            \n",
       "                                                                            "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(netflix)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "c1d3b838",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-01-15T23:15:13.778336Z",
     "iopub.status.busy": "2022-01-15T23:15:13.776373Z",
     "iopub.status.idle": "2022-01-15T23:15:13.818527Z",
     "shell.execute_reply": "2022-01-15T23:15:13.816591Z"
    },
    "jupyter": {
     "outputs_hidden": true,
     "source_hidden": true
    },
    "papermill": {
     "duration": 0.095062,
     "end_time": "2022-01-15T23:15:13.818673",
     "exception": false,
     "start_time": "2022-01-15T23:15:13.723611",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 12</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>show_id</th><th scope=col>type</th><th scope=col>title</th><th scope=col>director</th><th scope=col>cast</th><th scope=col>country</th><th scope=col>date_added</th><th scope=col>release_year</th><th scope=col>rating</th><th scope=col>duration</th><th scope=col>listed_in</th><th scope=col>description</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>s1</td><td>Movie  </td><td>Dick Johnson Is Dead </td><td>Kirsten Johnson</td><td>NA                                                                                                                                                                                                                                                                                                             </td><td>United States</td><td>September 25, 2021</td><td>2020</td><td>PG-13</td><td>90 min   </td><td>Documentaries                                                </td><td>As her father nears the end of his life, filmmaker Kirsten Johnson stages his death in inventive and comical ways to help them both face the inevitable.</td></tr>\n",
       "\t<tr><td>s2</td><td>TV Show</td><td><span style=white-space:pre-wrap>Blood &amp; Water        </span></td><td><span style=white-space:pre-wrap>NA             </span></td><td>Ama Qamata, Khosi Ngema, Gail Mabalane, Thabang Molaba, Dillon Windvogel, Natasha Thahane, Arno Greeff, Xolile Tshabalala, Getmore Sithole, Cindy Mahlangu, Ryle De Morny, Greteli Fincham, Sello Maake Ka-Ncube, Odwa Gwanya, Mekaila Mathys, Sandi Schultz, Duane Williams, Shamilla Miller, Patrick Mofokeng</td><td>South Africa </td><td>September 24, 2021</td><td>2021</td><td>TV-MA</td><td>2 Seasons</td><td><span style=white-space:pre-wrap>International TV Shows, TV Dramas, TV Mysteries              </span></td><td><span style=white-space:pre-wrap>After crossing paths at a party, a Cape Town teen sets out to prove whether a private-school swimming star is her sister who was abducted at birth.     </span></td></tr>\n",
       "\t<tr><td>s3</td><td>TV Show</td><td><span style=white-space:pre-wrap>Ganglands            </span></td><td>Julien Leclercq</td><td><span style=white-space:pre-wrap>Sami Bouajila, Tracy Gotoas, Samuel Jouy, Nabiha Akkari, Sofia Lesaffre, Salim Kechiouche, Noureddine Farihi, Geert Van Rampelberg, Bakary Diombera                                                                                                                                                            </span></td><td><span style=white-space:pre-wrap>NA           </span></td><td>September 24, 2021</td><td>2021</td><td>TV-MA</td><td>1 Season </td><td>Crime TV Shows, International TV Shows, TV Action &amp; Adventure</td><td><span style=white-space:pre-wrap>To protect his family from a powerful drug lord, skilled thief Mehdi and his expert team of robbers are pulled into a violent and deadly turf war.      </span></td></tr>\n",
       "\t<tr><td>s4</td><td>TV Show</td><td>Jailbirds New Orleans</td><td>NA             </td><td>NA                                                                                                                                                                                                                                                                                                             </td><td>NA           </td><td>September 24, 2021</td><td>2021</td><td>TV-MA</td><td>1 Season </td><td>Docuseries, Reality TV                                       </td><td>Feuds, flirtations and toilet talk go down among the incarcerated women at the Orleans Justice Center in New Orleans on this gritty reality series.     </td></tr>\n",
       "\t<tr><td>s5</td><td>TV Show</td><td>Kota Factory         </td><td>NA             </td><td>Mayur More, Jitendra Kumar, Ranjan Raj, Alam Khan, Ahsaas Channa, Revathi Pillai, Urvi Singh, Arun Kumar                                                                                                                                                                                                       </td><td>India        </td><td>September 24, 2021</td><td>2021</td><td>TV-MA</td><td>2 Seasons</td><td>International TV Shows, Romantic TV Shows, TV Comedies       </td><td>In a city of coaching centers known to train India’s finest collegiate minds, an earnest but unexceptional student and his friends navigate campus life.</td></tr>\n",
       "\t<tr><td>s6</td><td>TV Show</td><td>Midnight Mass        </td><td>Mike Flanagan  </td><td>Kate Siegel, Zach Gilford, Hamish Linklater, Henry Thomas, Kristin Lehman, Samantha Sloyan, Igby Rigney, Rahul Kohli, Annarah Cymone, Annabeth Gish, Alex Essoe, Rahul Abburi, Matt Biedel, Michael Trucco, Crystal Balint, Louis Oliver                                                                       </td><td>NA           </td><td>September 24, 2021</td><td>2021</td><td>TV-MA</td><td>1 Season </td><td>TV Dramas, TV Horror, TV Mysteries                           </td><td>The arrival of a charismatic young priest brings glorious miracles, ominous mysteries and renewed religious fervor to a dying town desperate to believe.</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 12\n",
       "\\begin{tabular}{llllllllllll}\n",
       " show\\_id & type & title & director & cast & country & date\\_added & release\\_year & rating & duration & listed\\_in & description\\\\\n",
       " <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <chr> & <dbl> & <chr> & <chr> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t s1 & Movie   & Dick Johnson Is Dead  & Kirsten Johnson & NA                                                                                                                                                                                                                                                                                                              & United States & September 25, 2021 & 2020 & PG-13 & 90 min    & Documentaries                                                 & As her father nears the end of his life, filmmaker Kirsten Johnson stages his death in inventive and comical ways to help them both face the inevitable.\\\\\n",
       "\t s2 & TV Show & Blood \\& Water         & NA              & Ama Qamata, Khosi Ngema, Gail Mabalane, Thabang Molaba, Dillon Windvogel, Natasha Thahane, Arno Greeff, Xolile Tshabalala, Getmore Sithole, Cindy Mahlangu, Ryle De Morny, Greteli Fincham, Sello Maake Ka-Ncube, Odwa Gwanya, Mekaila Mathys, Sandi Schultz, Duane Williams, Shamilla Miller, Patrick Mofokeng & South Africa  & September 24, 2021 & 2021 & TV-MA & 2 Seasons & International TV Shows, TV Dramas, TV Mysteries               & After crossing paths at a party, a Cape Town teen sets out to prove whether a private-school swimming star is her sister who was abducted at birth.     \\\\\n",
       "\t s3 & TV Show & Ganglands             & Julien Leclercq & Sami Bouajila, Tracy Gotoas, Samuel Jouy, Nabiha Akkari, Sofia Lesaffre, Salim Kechiouche, Noureddine Farihi, Geert Van Rampelberg, Bakary Diombera                                                                                                                                                             & NA            & September 24, 2021 & 2021 & TV-MA & 1 Season  & Crime TV Shows, International TV Shows, TV Action \\& Adventure & To protect his family from a powerful drug lord, skilled thief Mehdi and his expert team of robbers are pulled into a violent and deadly turf war.      \\\\\n",
       "\t s4 & TV Show & Jailbirds New Orleans & NA              & NA                                                                                                                                                                                                                                                                                                              & NA            & September 24, 2021 & 2021 & TV-MA & 1 Season  & Docuseries, Reality TV                                        & Feuds, flirtations and toilet talk go down among the incarcerated women at the Orleans Justice Center in New Orleans on this gritty reality series.     \\\\\n",
       "\t s5 & TV Show & Kota Factory          & NA              & Mayur More, Jitendra Kumar, Ranjan Raj, Alam Khan, Ahsaas Channa, Revathi Pillai, Urvi Singh, Arun Kumar                                                                                                                                                                                                        & India         & September 24, 2021 & 2021 & TV-MA & 2 Seasons & International TV Shows, Romantic TV Shows, TV Comedies        & In a city of coaching centers known to train India’s finest collegiate minds, an earnest but unexceptional student and his friends navigate campus life.\\\\\n",
       "\t s6 & TV Show & Midnight Mass         & Mike Flanagan   & Kate Siegel, Zach Gilford, Hamish Linklater, Henry Thomas, Kristin Lehman, Samantha Sloyan, Igby Rigney, Rahul Kohli, Annarah Cymone, Annabeth Gish, Alex Essoe, Rahul Abburi, Matt Biedel, Michael Trucco, Crystal Balint, Louis Oliver                                                                        & NA            & September 24, 2021 & 2021 & TV-MA & 1 Season  & TV Dramas, TV Horror, TV Mysteries                            & The arrival of a charismatic young priest brings glorious miracles, ominous mysteries and renewed religious fervor to a dying town desperate to believe.\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 12\n",
       "\n",
       "| show_id &lt;chr&gt; | type &lt;chr&gt; | title &lt;chr&gt; | director &lt;chr&gt; | cast &lt;chr&gt; | country &lt;chr&gt; | date_added &lt;chr&gt; | release_year &lt;dbl&gt; | rating &lt;chr&gt; | duration &lt;chr&gt; | listed_in &lt;chr&gt; | description &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| s1 | Movie   | Dick Johnson Is Dead  | Kirsten Johnson | NA                                                                                                                                                                                                                                                                                                              | United States | September 25, 2021 | 2020 | PG-13 | 90 min    | Documentaries                                                 | As her father nears the end of his life, filmmaker Kirsten Johnson stages his death in inventive and comical ways to help them both face the inevitable. |\n",
       "| s2 | TV Show | Blood &amp; Water         | NA              | Ama Qamata, Khosi Ngema, Gail Mabalane, Thabang Molaba, Dillon Windvogel, Natasha Thahane, Arno Greeff, Xolile Tshabalala, Getmore Sithole, Cindy Mahlangu, Ryle De Morny, Greteli Fincham, Sello Maake Ka-Ncube, Odwa Gwanya, Mekaila Mathys, Sandi Schultz, Duane Williams, Shamilla Miller, Patrick Mofokeng | South Africa  | September 24, 2021 | 2021 | TV-MA | 2 Seasons | International TV Shows, TV Dramas, TV Mysteries               | After crossing paths at a party, a Cape Town teen sets out to prove whether a private-school swimming star is her sister who was abducted at birth.      |\n",
       "| s3 | TV Show | Ganglands             | Julien Leclercq | Sami Bouajila, Tracy Gotoas, Samuel Jouy, Nabiha Akkari, Sofia Lesaffre, Salim Kechiouche, Noureddine Farihi, Geert Van Rampelberg, Bakary Diombera                                                                                                                                                             | NA            | September 24, 2021 | 2021 | TV-MA | 1 Season  | Crime TV Shows, International TV Shows, TV Action &amp; Adventure | To protect his family from a powerful drug lord, skilled thief Mehdi and his expert team of robbers are pulled into a violent and deadly turf war.       |\n",
       "| s4 | TV Show | Jailbirds New Orleans | NA              | NA                                                                                                                                                                                                                                                                                                              | NA            | September 24, 2021 | 2021 | TV-MA | 1 Season  | Docuseries, Reality TV                                        | Feuds, flirtations and toilet talk go down among the incarcerated women at the Orleans Justice Center in New Orleans on this gritty reality series.      |\n",
       "| s5 | TV Show | Kota Factory          | NA              | Mayur More, Jitendra Kumar, Ranjan Raj, Alam Khan, Ahsaas Channa, Revathi Pillai, Urvi Singh, Arun Kumar                                                                                                                                                                                                        | India         | September 24, 2021 | 2021 | TV-MA | 2 Seasons | International TV Shows, Romantic TV Shows, TV Comedies        | In a city of coaching centers known to train India’s finest collegiate minds, an earnest but unexceptional student and his friends navigate campus life. |\n",
       "| s6 | TV Show | Midnight Mass         | Mike Flanagan   | Kate Siegel, Zach Gilford, Hamish Linklater, Henry Thomas, Kristin Lehman, Samantha Sloyan, Igby Rigney, Rahul Kohli, Annarah Cymone, Annabeth Gish, Alex Essoe, Rahul Abburi, Matt Biedel, Michael Trucco, Crystal Balint, Louis Oliver                                                                        | NA            | September 24, 2021 | 2021 | TV-MA | 1 Season  | TV Dramas, TV Horror, TV Mysteries                            | The arrival of a charismatic young priest brings glorious miracles, ominous mysteries and renewed religious fervor to a dying town desperate to believe. |\n",
       "\n"
      ],
      "text/plain": [
       "  show_id type    title                 director       \n",
       "1 s1      Movie   Dick Johnson Is Dead  Kirsten Johnson\n",
       "2 s2      TV Show Blood & Water         NA             \n",
       "3 s3      TV Show Ganglands             Julien Leclercq\n",
       "4 s4      TV Show Jailbirds New Orleans NA             \n",
       "5 s5      TV Show Kota Factory          NA             \n",
       "6 s6      TV Show Midnight Mass         Mike Flanagan  \n",
       "  cast                                                                                                                                                                                                                                                                                                           \n",
       "1 NA                                                                                                                                                                                                                                                                                                             \n",
       "2 Ama Qamata, Khosi Ngema, Gail Mabalane, Thabang Molaba, Dillon Windvogel, Natasha Thahane, Arno Greeff, Xolile Tshabalala, Getmore Sithole, Cindy Mahlangu, Ryle De Morny, Greteli Fincham, Sello Maake Ka-Ncube, Odwa Gwanya, Mekaila Mathys, Sandi Schultz, Duane Williams, Shamilla Miller, Patrick Mofokeng\n",
       "3 Sami Bouajila, Tracy Gotoas, Samuel Jouy, Nabiha Akkari, Sofia Lesaffre, Salim Kechiouche, Noureddine Farihi, Geert Van Rampelberg, Bakary Diombera                                                                                                                                                            \n",
       "4 NA                                                                                                                                                                                                                                                                                                             \n",
       "5 Mayur More, Jitendra Kumar, Ranjan Raj, Alam Khan, Ahsaas Channa, Revathi Pillai, Urvi Singh, Arun Kumar                                                                                                                                                                                                       \n",
       "6 Kate Siegel, Zach Gilford, Hamish Linklater, Henry Thomas, Kristin Lehman, Samantha Sloyan, Igby Rigney, Rahul Kohli, Annarah Cymone, Annabeth Gish, Alex Essoe, Rahul Abburi, Matt Biedel, Michael Trucco, Crystal Balint, Louis Oliver                                                                       \n",
       "  country       date_added         release_year rating duration \n",
       "1 United States September 25, 2021 2020         PG-13  90 min   \n",
       "2 South Africa  September 24, 2021 2021         TV-MA  2 Seasons\n",
       "3 NA            September 24, 2021 2021         TV-MA  1 Season \n",
       "4 NA            September 24, 2021 2021         TV-MA  1 Season \n",
       "5 India         September 24, 2021 2021         TV-MA  2 Seasons\n",
       "6 NA            September 24, 2021 2021         TV-MA  1 Season \n",
       "  listed_in                                                    \n",
       "1 Documentaries                                                \n",
       "2 International TV Shows, TV Dramas, TV Mysteries              \n",
       "3 Crime TV Shows, International TV Shows, TV Action & Adventure\n",
       "4 Docuseries, Reality TV                                       \n",
       "5 International TV Shows, Romantic TV Shows, TV Comedies       \n",
       "6 TV Dramas, TV Horror, TV Mysteries                           \n",
       "  description                                                                                                                                             \n",
       "1 As her father nears the end of his life, filmmaker Kirsten Johnson stages his death in inventive and comical ways to help them both face the inevitable.\n",
       "2 After crossing paths at a party, a Cape Town teen sets out to prove whether a private-school swimming star is her sister who was abducted at birth.     \n",
       "3 To protect his family from a powerful drug lord, skilled thief Mehdi and his expert team of robbers are pulled into a violent and deadly turf war.      \n",
       "4 Feuds, flirtations and toilet talk go down among the incarcerated women at the Orleans Justice Center in New Orleans on this gritty reality series.     \n",
       "5 In a city of coaching centers known to train India’s finest collegiate minds, an earnest but unexceptional student and his friends navigate campus life.\n",
       "6 The arrival of a charismatic young priest brings glorious miracles, ominous mysteries and renewed religious fervor to a dying town desperate to believe."
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(netflix)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "9be5f3c2",
   "metadata": {
    "papermill": {
     "duration": 0.053067,
     "end_time": "2022-01-15T23:15:13.922337",
     "exception": false,
     "start_time": "2022-01-15T23:15:13.869270",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Looking for which colums have NA values"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "70c07eec",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-15T23:15:14.029618Z",
     "iopub.status.busy": "2022-01-15T23:15:14.027994Z",
     "iopub.status.idle": "2022-01-15T23:15:14.101428Z",
     "shell.execute_reply": "2022-01-15T23:15:14.099557Z"
    },
    "papermill": {
     "duration": 0.129316,
     "end_time": "2022-01-15T23:15:14.101611",
     "exception": false,
     "start_time": "2022-01-15T23:15:13.972295",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'director'</li><li>'cast'</li><li>'country'</li><li>'date_added'</li><li>'rating'</li><li>'duration'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'director'\n",
       "\\item 'cast'\n",
       "\\item 'country'\n",
       "\\item 'date\\_added'\n",
       "\\item 'rating'\n",
       "\\item 'duration'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'director'\n",
       "2. 'cast'\n",
       "3. 'country'\n",
       "4. 'date_added'\n",
       "5. 'rating'\n",
       "6. 'duration'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"director\"   \"cast\"       \"country\"    \"date_added\" \"rating\"    \n",
       "[6] \"duration\"  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "names(which(colSums(is.na(netflix)) > 0))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "953a047b",
   "metadata": {
    "papermill": {
     "duration": 0.052973,
     "end_time": "2022-01-15T23:15:14.208201",
     "exception": false,
     "start_time": "2022-01-15T23:15:14.155228",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "director, cast, country, date_added, rating, and duration have null values. These will need to be dealt with. "
   ]
  },
  {
   "cell_type": "markdown",
   "id": "b4368b81",
   "metadata": {
    "papermill": {
     "duration": 0.053045,
     "end_time": "2022-01-15T23:15:14.314518",
     "exception": false,
     "start_time": "2022-01-15T23:15:14.261473",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# What are the top 10 countries for TV Shows and what is their most frequent genre (listed_in)?"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d26bde08",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-15T22:58:03.621437Z",
     "iopub.status.busy": "2022-01-15T22:58:03.619745Z",
     "iopub.status.idle": "2022-01-15T22:58:03.668137Z"
    },
    "papermill": {
     "duration": 0.052984,
     "end_time": "2022-01-15T23:15:14.420436",
     "exception": false,
     "start_time": "2022-01-15T23:15:14.367452",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### 1. We saw that we have NA values in the countries column. We will have to remove these before proceeding further."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "c8cb846b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-15T23:15:14.534515Z",
     "iopub.status.busy": "2022-01-15T23:15:14.532241Z",
     "iopub.status.idle": "2022-01-15T23:15:14.594459Z",
     "shell.execute_reply": "2022-01-15T23:15:14.592939Z"
    },
    "papermill": {
     "duration": 0.12078,
     "end_time": "2022-01-15T23:15:14.594621",
     "exception": false,
     "start_time": "2022-01-15T23:15:14.473841",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.0943567616668559"
      ],
      "text/latex": [
       "0.0943567616668559"
      ],
      "text/markdown": [
       "0.0943567616668559"
      ],
      "text/plain": [
       "[1] 0.09435676"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "countries<-netflix%>%\n",
    "  select(country, type, listed_in)\n",
    "\n",
    "sum(is.na(countries$country))/nrow(countries)\n",
    "#country NA's rate: 1% => delete them(NA value)\n",
    "\n",
    "countries<-countries%>%\n",
    "  filter(!is.na(country))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "cc6c75f0",
   "metadata": {
    "collapsed": true,
    "execution": {
     "iopub.execute_input": "2022-01-15T23:15:14.713756Z",
     "iopub.status.busy": "2022-01-15T23:15:14.711671Z",
     "iopub.status.idle": "2022-01-15T23:15:14.829973Z",
     "shell.execute_reply": "2022-01-15T23:15:14.828029Z"
    },
    "jupyter": {
     "outputs_hidden": true
    },
    "papermill": {
     "duration": 0.179166,
     "end_time": "2022-01-15T23:15:14.830148",
     "exception": false,
     "start_time": "2022-01-15T23:15:14.650982",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 7976 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>country</th><th scope=col>type</th><th scope=col>listed_in</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>United States                                                        </td><td>Movie  </td><td>Documentaries                                           </td></tr>\n",
       "\t<tr><td>South Africa                                                         </td><td>TV Show</td><td>International TV Shows, TV Dramas, TV Mysteries         </td></tr>\n",
       "\t<tr><td>India                                                                </td><td>TV Show</td><td>International TV Shows, Romantic TV Shows, TV Comedies  </td></tr>\n",
       "\t<tr><td>United States, Ghana, Burkina Faso, United Kingdom, Germany, Ethiopia</td><td>Movie  </td><td>Dramas, Independent Movies, International Movies        </td></tr>\n",
       "\t<tr><td>United Kingdom                                                       </td><td>TV Show</td><td>British TV Shows, Reality TV                            </td></tr>\n",
       "\t<tr><td>United States                                                        </td><td>Movie  </td><td>Comedies, Dramas                                        </td></tr>\n",
       "\t<tr><td>Germany, Czech Republic                                              </td><td>Movie  </td><td>Dramas, International Movies                            </td></tr>\n",
       "\t<tr><td>United States                                                        </td><td>TV Show</td><td>TV Comedies, TV Dramas                                  </td></tr>\n",
       "\t<tr><td>Mexico                                                               </td><td>TV Show</td><td>Crime TV Shows, Spanish-Language TV Shows, TV Dramas    </td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Turkey                                                               </span></td><td>TV Show</td><td>International TV Shows, TV Action &amp; Adventure, TV Dramas</td></tr>\n",
       "\t<tr><td>India                                                                </td><td>Movie  </td><td>Comedies, International Movies, Romantic Movies         </td></tr>\n",
       "\t<tr><td>Australia                                                            </td><td>TV Show</td><td>Docuseries, International TV Shows, Reality TV          </td></tr>\n",
       "\t<tr><td>United States                                                        </td><td>Movie  </td><td>Comedies                                                </td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>United States                                                        </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Horror Movies, Sci-Fi &amp; Fantasy                         </span></td></tr>\n",
       "\t<tr><td>United States, India, France                                         </td><td>Movie  </td><td>Thrillers                                               </td></tr>\n",
       "\t<tr><td>United Kingdom                                                       </td><td>TV Show</td><td>British TV Shows, International TV Shows, TV Comedies   </td></tr>\n",
       "\t<tr><td>Finland                                                              </td><td>TV Show</td><td>Kids' TV, TV Comedies                                   </td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>China, Canada, United States                                         </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Action &amp; Adventure, Dramas                              </span></td></tr>\n",
       "\t<tr><td>India                                                                </td><td>TV Show</td><td>Kids' TV                                                </td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>United States                                                        </span></td><td>TV Show</td><td><span style=white-space:pre-wrap>Kids' TV, TV Sci-Fi &amp; Fantasy                           </span></td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>United States                                                        </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Action &amp; Adventure, Classic Movies, Dramas              </span></td></tr>\n",
       "\t<tr><td>United States                                                        </td><td>Movie  </td><td>Dramas, Horror Movies, Thrillers                        </td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>United States                                                        </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Action &amp; Adventure, Horror Movies, Thrillers            </span></td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>United States                                                        </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Action &amp; Adventure, Horror Movies, Thrillers            </span></td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>South Africa, United States, Japan                                   </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Action &amp; Adventure                                      </span></td></tr>\n",
       "\t<tr><td>United States                                                        </td><td>Movie  </td><td>Dramas, Thrillers                                       </td></tr>\n",
       "\t<tr><td>Nigeria                                                              </td><td>TV Show</td><td>International TV Shows, TV Dramas                       </td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>India                                                                </span></td><td>TV Show</td><td><span style=white-space:pre-wrap>International TV Shows, TV Dramas, TV Sci-Fi &amp; Fantasy  </span></td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Japan                                                                </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td>Action &amp; Adventure, Anime Features, International Movies</td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Japan                                                                </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td>Action &amp; Adventure, Anime Features, International Movies</td></tr>\n",
       "\t<tr><td>⋮</td><td>⋮</td><td>⋮</td></tr>\n",
       "\t<tr><td>Egypt, Austria, United States                </td><td>Movie  </td><td>Dramas, Independent Movies, International Movies    </td></tr>\n",
       "\t<tr><td>India                                        </td><td>TV Show</td><td>International TV Shows, TV Comedies                 </td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>France, Belgium                              </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Children &amp; Family Movies, Comedies                  </span></td></tr>\n",
       "\t<tr><td>Thailand                                     </td><td>Movie  </td><td>International Movies, LGBTQ Movies, Romantic Movies </td></tr>\n",
       "\t<tr><td>Thailand                                     </td><td>Movie  </td><td>International Movies, LGBTQ Movies, Romantic Movies </td></tr>\n",
       "\t<tr><td>Thailand                                     </td><td>Movie  </td><td>International Movies, LGBTQ Movies, Romantic Movies </td></tr>\n",
       "\t<tr><td>United States                                </td><td>TV Show</td><td>Anime Series, Kids' TV                              </td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Japan, United States                         </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Anime Features, Children &amp; Family Movies            </span></td></tr>\n",
       "\t<tr><td>United States                                </td><td>Movie  </td><td>Comedies, Horror Movies, Independent Movies         </td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Russia, Spain                                </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Children &amp; Family Movies                            </span></td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>United Kingdom                               </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Children &amp; Family Movies                            </span></td></tr>\n",
       "\t<tr><td>United States                                </td><td>Movie  </td><td>Comedies, Romantic Movies                           </td></tr>\n",
       "\t<tr><td>Croatia, Slovenia, Serbia, Montenegro        </td><td>Movie  </td><td>Dramas, International Movies                        </td></tr>\n",
       "\t<tr><td>Philippines                                  </td><td>Movie  </td><td>Comedies, Dramas, International Movies              </td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>United States                                </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Action &amp; Adventure, Comedies                        </span></td></tr>\n",
       "\t<tr><td>United States                                </td><td>Movie  </td><td>Comedies, Dramas, Independent Movies                </td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>Hong Kong                                    </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Action &amp; Adventure, International Movies            </span></td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>United States                                </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Children &amp; Family Movies, Comedies                  </span></td></tr>\n",
       "\t<tr><td>Egypt, France                                </td><td>Movie  </td><td>Dramas, Independent Movies, International Movies    </td></tr>\n",
       "\t<tr><td>Japan, Canada                                </td><td>TV Show</td><td>Anime Series, Kids' TV                              </td></tr>\n",
       "\t<tr><td>Turkey                                       </td><td>TV Show</td><td>International TV Shows, TV Dramas                   </td></tr>\n",
       "\t<tr><td>United States, France, South Korea, Indonesia</td><td>TV Show</td><td>Kids' TV                                            </td></tr>\n",
       "\t<tr><td>India                                        </td><td>Movie  </td><td>Comedies, Dramas, International Movies              </td></tr>\n",
       "\t<tr><td>India                                        </td><td>Movie  </td><td>Dramas, International Movies                        </td></tr>\n",
       "\t<tr><td>Pakistan                                     </td><td>TV Show</td><td>International TV Shows, Romantic TV Shows, TV Dramas</td></tr>\n",
       "\t<tr><td>United Arab Emirates, Jordan                 </td><td>Movie  </td><td>Dramas, International Movies, Thrillers             </td></tr>\n",
       "\t<tr><td>United States                                </td><td>Movie  </td><td>Cult Movies, Dramas, Thrillers                      </td></tr>\n",
       "\t<tr><td>United States                                </td><td>Movie  </td><td>Comedies, Horror Movies                             </td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>United States                                </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Children &amp; Family Movies, Comedies                  </span></td></tr>\n",
       "\t<tr><td><span style=white-space:pre-wrap>India                                        </span></td><td><span style=white-space:pre-wrap>Movie  </span></td><td><span style=white-space:pre-wrap>Dramas, International Movies, Music &amp; Musicals      </span></td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 7976 × 3\n",
       "\\begin{tabular}{lll}\n",
       " country & type & listed\\_in\\\\\n",
       " <chr> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t United States                                                         & Movie   & Documentaries                                           \\\\\n",
       "\t South Africa                                                          & TV Show & International TV Shows, TV Dramas, TV Mysteries         \\\\\n",
       "\t India                                                                 & TV Show & International TV Shows, Romantic TV Shows, TV Comedies  \\\\\n",
       "\t United States, Ghana, Burkina Faso, United Kingdom, Germany, Ethiopia & Movie   & Dramas, Independent Movies, International Movies        \\\\\n",
       "\t United Kingdom                                                        & TV Show & British TV Shows, Reality TV                            \\\\\n",
       "\t United States                                                         & Movie   & Comedies, Dramas                                        \\\\\n",
       "\t Germany, Czech Republic                                               & Movie   & Dramas, International Movies                            \\\\\n",
       "\t United States                                                         & TV Show & TV Comedies, TV Dramas                                  \\\\\n",
       "\t Mexico                                                                & TV Show & Crime TV Shows, Spanish-Language TV Shows, TV Dramas    \\\\\n",
       "\t Turkey                                                                & TV Show & International TV Shows, TV Action \\& Adventure, TV Dramas\\\\\n",
       "\t India                                                                 & Movie   & Comedies, International Movies, Romantic Movies         \\\\\n",
       "\t Australia                                                             & TV Show & Docuseries, International TV Shows, Reality TV          \\\\\n",
       "\t United States                                                         & Movie   & Comedies                                                \\\\\n",
       "\t United States                                                         & Movie   & Horror Movies, Sci-Fi \\& Fantasy                         \\\\\n",
       "\t United States, India, France                                          & Movie   & Thrillers                                               \\\\\n",
       "\t United Kingdom                                                        & TV Show & British TV Shows, International TV Shows, TV Comedies   \\\\\n",
       "\t Finland                                                               & TV Show & Kids' TV, TV Comedies                                   \\\\\n",
       "\t China, Canada, United States                                          & Movie   & Action \\& Adventure, Dramas                              \\\\\n",
       "\t India                                                                 & TV Show & Kids' TV                                                \\\\\n",
       "\t United States                                                         & TV Show & Kids' TV, TV Sci-Fi \\& Fantasy                           \\\\\n",
       "\t United States                                                         & Movie   & Action \\& Adventure, Classic Movies, Dramas              \\\\\n",
       "\t United States                                                         & Movie   & Dramas, Horror Movies, Thrillers                        \\\\\n",
       "\t United States                                                         & Movie   & Action \\& Adventure, Horror Movies, Thrillers            \\\\\n",
       "\t United States                                                         & Movie   & Action \\& Adventure, Horror Movies, Thrillers            \\\\\n",
       "\t South Africa, United States, Japan                                    & Movie   & Action \\& Adventure                                      \\\\\n",
       "\t United States                                                         & Movie   & Dramas, Thrillers                                       \\\\\n",
       "\t Nigeria                                                               & TV Show & International TV Shows, TV Dramas                       \\\\\n",
       "\t India                                                                 & TV Show & International TV Shows, TV Dramas, TV Sci-Fi \\& Fantasy  \\\\\n",
       "\t Japan                                                                 & Movie   & Action \\& Adventure, Anime Features, International Movies\\\\\n",
       "\t Japan                                                                 & Movie   & Action \\& Adventure, Anime Features, International Movies\\\\\n",
       "\t ⋮ & ⋮ & ⋮\\\\\n",
       "\t Egypt, Austria, United States                 & Movie   & Dramas, Independent Movies, International Movies    \\\\\n",
       "\t India                                         & TV Show & International TV Shows, TV Comedies                 \\\\\n",
       "\t France, Belgium                               & Movie   & Children \\& Family Movies, Comedies                  \\\\\n",
       "\t Thailand                                      & Movie   & International Movies, LGBTQ Movies, Romantic Movies \\\\\n",
       "\t Thailand                                      & Movie   & International Movies, LGBTQ Movies, Romantic Movies \\\\\n",
       "\t Thailand                                      & Movie   & International Movies, LGBTQ Movies, Romantic Movies \\\\\n",
       "\t United States                                 & TV Show & Anime Series, Kids' TV                              \\\\\n",
       "\t Japan, United States                          & Movie   & Anime Features, Children \\& Family Movies            \\\\\n",
       "\t United States                                 & Movie   & Comedies, Horror Movies, Independent Movies         \\\\\n",
       "\t Russia, Spain                                 & Movie   & Children \\& Family Movies                            \\\\\n",
       "\t United Kingdom                                & Movie   & Children \\& Family Movies                            \\\\\n",
       "\t United States                                 & Movie   & Comedies, Romantic Movies                           \\\\\n",
       "\t Croatia, Slovenia, Serbia, Montenegro         & Movie   & Dramas, International Movies                        \\\\\n",
       "\t Philippines                                   & Movie   & Comedies, Dramas, International Movies              \\\\\n",
       "\t United States                                 & Movie   & Action \\& Adventure, Comedies                        \\\\\n",
       "\t United States                                 & Movie   & Comedies, Dramas, Independent Movies                \\\\\n",
       "\t Hong Kong                                     & Movie   & Action \\& Adventure, International Movies            \\\\\n",
       "\t United States                                 & Movie   & Children \\& Family Movies, Comedies                  \\\\\n",
       "\t Egypt, France                                 & Movie   & Dramas, Independent Movies, International Movies    \\\\\n",
       "\t Japan, Canada                                 & TV Show & Anime Series, Kids' TV                              \\\\\n",
       "\t Turkey                                        & TV Show & International TV Shows, TV Dramas                   \\\\\n",
       "\t United States, France, South Korea, Indonesia & TV Show & Kids' TV                                            \\\\\n",
       "\t India                                         & Movie   & Comedies, Dramas, International Movies              \\\\\n",
       "\t India                                         & Movie   & Dramas, International Movies                        \\\\\n",
       "\t Pakistan                                      & TV Show & International TV Shows, Romantic TV Shows, TV Dramas\\\\\n",
       "\t United Arab Emirates, Jordan                  & Movie   & Dramas, International Movies, Thrillers             \\\\\n",
       "\t United States                                 & Movie   & Cult Movies, Dramas, Thrillers                      \\\\\n",
       "\t United States                                 & Movie   & Comedies, Horror Movies                             \\\\\n",
       "\t United States                                 & Movie   & Children \\& Family Movies, Comedies                  \\\\\n",
       "\t India                                         & Movie   & Dramas, International Movies, Music \\& Musicals      \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 7976 × 3\n",
       "\n",
       "| country &lt;chr&gt; | type &lt;chr&gt; | listed_in &lt;chr&gt; |\n",
       "|---|---|---|\n",
       "| United States                                                         | Movie   | Documentaries                                            |\n",
       "| South Africa                                                          | TV Show | International TV Shows, TV Dramas, TV Mysteries          |\n",
       "| India                                                                 | TV Show | International TV Shows, Romantic TV Shows, TV Comedies   |\n",
       "| United States, Ghana, Burkina Faso, United Kingdom, Germany, Ethiopia | Movie   | Dramas, Independent Movies, International Movies         |\n",
       "| United Kingdom                                                        | TV Show | British TV Shows, Reality TV                             |\n",
       "| United States                                                         | Movie   | Comedies, Dramas                                         |\n",
       "| Germany, Czech Republic                                               | Movie   | Dramas, International Movies                             |\n",
       "| United States                                                         | TV Show | TV Comedies, TV Dramas                                   |\n",
       "| Mexico                                                                | TV Show | Crime TV Shows, Spanish-Language TV Shows, TV Dramas     |\n",
       "| Turkey                                                                | TV Show | International TV Shows, TV Action &amp; Adventure, TV Dramas |\n",
       "| India                                                                 | Movie   | Comedies, International Movies, Romantic Movies          |\n",
       "| Australia                                                             | TV Show | Docuseries, International TV Shows, Reality TV           |\n",
       "| United States                                                         | Movie   | Comedies                                                 |\n",
       "| United States                                                         | Movie   | Horror Movies, Sci-Fi &amp; Fantasy                          |\n",
       "| United States, India, France                                          | Movie   | Thrillers                                                |\n",
       "| United Kingdom                                                        | TV Show | British TV Shows, International TV Shows, TV Comedies    |\n",
       "| Finland                                                               | TV Show | Kids' TV, TV Comedies                                    |\n",
       "| China, Canada, United States                                          | Movie   | Action &amp; Adventure, Dramas                               |\n",
       "| India                                                                 | TV Show | Kids' TV                                                 |\n",
       "| United States                                                         | TV Show | Kids' TV, TV Sci-Fi &amp; Fantasy                            |\n",
       "| United States                                                         | Movie   | Action &amp; Adventure, Classic Movies, Dramas               |\n",
       "| United States                                                         | Movie   | Dramas, Horror Movies, Thrillers                         |\n",
       "| United States                                                         | Movie   | Action &amp; Adventure, Horror Movies, Thrillers             |\n",
       "| United States                                                         | Movie   | Action &amp; Adventure, Horror Movies, Thrillers             |\n",
       "| South Africa, United States, Japan                                    | Movie   | Action &amp; Adventure                                       |\n",
       "| United States                                                         | Movie   | Dramas, Thrillers                                        |\n",
       "| Nigeria                                                               | TV Show | International TV Shows, TV Dramas                        |\n",
       "| India                                                                 | TV Show | International TV Shows, TV Dramas, TV Sci-Fi &amp; Fantasy   |\n",
       "| Japan                                                                 | Movie   | Action &amp; Adventure, Anime Features, International Movies |\n",
       "| Japan                                                                 | Movie   | Action &amp; Adventure, Anime Features, International Movies |\n",
       "| ⋮ | ⋮ | ⋮ |\n",
       "| Egypt, Austria, United States                 | Movie   | Dramas, Independent Movies, International Movies     |\n",
       "| India                                         | TV Show | International TV Shows, TV Comedies                  |\n",
       "| France, Belgium                               | Movie   | Children &amp; Family Movies, Comedies                   |\n",
       "| Thailand                                      | Movie   | International Movies, LGBTQ Movies, Romantic Movies  |\n",
       "| Thailand                                      | Movie   | International Movies, LGBTQ Movies, Romantic Movies  |\n",
       "| Thailand                                      | Movie   | International Movies, LGBTQ Movies, Romantic Movies  |\n",
       "| United States                                 | TV Show | Anime Series, Kids' TV                               |\n",
       "| Japan, United States                          | Movie   | Anime Features, Children &amp; Family Movies             |\n",
       "| United States                                 | Movie   | Comedies, Horror Movies, Independent Movies          |\n",
       "| Russia, Spain                                 | Movie   | Children &amp; Family Movies                             |\n",
       "| United Kingdom                                | Movie   | Children &amp; Family Movies                             |\n",
       "| United States                                 | Movie   | Comedies, Romantic Movies                            |\n",
       "| Croatia, Slovenia, Serbia, Montenegro         | Movie   | Dramas, International Movies                         |\n",
       "| Philippines                                   | Movie   | Comedies, Dramas, International Movies               |\n",
       "| United States                                 | Movie   | Action &amp; Adventure, Comedies                         |\n",
       "| United States                                 | Movie   | Comedies, Dramas, Independent Movies                 |\n",
       "| Hong Kong                                     | Movie   | Action &amp; Adventure, International Movies             |\n",
       "| United States                                 | Movie   | Children &amp; Family Movies, Comedies                   |\n",
       "| Egypt, France                                 | Movie   | Dramas, Independent Movies, International Movies     |\n",
       "| Japan, Canada                                 | TV Show | Anime Series, Kids' TV                               |\n",
       "| Turkey                                        | TV Show | International TV Shows, TV Dramas                    |\n",
       "| United States, France, South Korea, Indonesia | TV Show | Kids' TV                                             |\n",
       "| India                                         | Movie   | Comedies, Dramas, International Movies               |\n",
       "| India                                         | Movie   | Dramas, International Movies                         |\n",
       "| Pakistan                                      | TV Show | International TV Shows, Romantic TV Shows, TV Dramas |\n",
       "| United Arab Emirates, Jordan                  | Movie   | Dramas, International Movies, Thrillers              |\n",
       "| United States                                 | Movie   | Cult Movies, Dramas, Thrillers                       |\n",
       "| United States                                 | Movie   | Comedies, Horror Movies                              |\n",
       "| United States                                 | Movie   | Children &amp; Family Movies, Comedies                   |\n",
       "| India                                         | Movie   | Dramas, International Movies, Music &amp; Musicals       |\n",
       "\n"
      ],
      "text/plain": [
       "     country                                                              \n",
       "1    United States                                                        \n",
       "2    South Africa                                                         \n",
       "3    India                                                                \n",
       "4    United States, Ghana, Burkina Faso, United Kingdom, Germany, Ethiopia\n",
       "5    United Kingdom                                                       \n",
       "6    United States                                                        \n",
       "7    Germany, Czech Republic                                              \n",
       "8    United States                                                        \n",
       "9    Mexico                                                               \n",
       "10   Turkey                                                               \n",
       "11   India                                                                \n",
       "12   Australia                                                            \n",
       "13   United States                                                        \n",
       "14   United States                                                        \n",
       "15   United States, India, France                                         \n",
       "16   United Kingdom                                                       \n",
       "17   Finland                                                              \n",
       "18   China, Canada, United States                                         \n",
       "19   India                                                                \n",
       "20   United States                                                        \n",
       "21   United States                                                        \n",
       "22   United States                                                        \n",
       "23   United States                                                        \n",
       "24   United States                                                        \n",
       "25   South Africa, United States, Japan                                   \n",
       "26   United States                                                        \n",
       "27   Nigeria                                                              \n",
       "28   India                                                                \n",
       "29   Japan                                                                \n",
       "30   Japan                                                                \n",
       "⋮    ⋮                                                                    \n",
       "7947 Egypt, Austria, United States                                        \n",
       "7948 India                                                                \n",
       "7949 France, Belgium                                                      \n",
       "7950 Thailand                                                             \n",
       "7951 Thailand                                                             \n",
       "7952 Thailand                                                             \n",
       "7953 United States                                                        \n",
       "7954 Japan, United States                                                 \n",
       "7955 United States                                                        \n",
       "7956 Russia, Spain                                                        \n",
       "7957 United Kingdom                                                       \n",
       "7958 United States                                                        \n",
       "7959 Croatia, Slovenia, Serbia, Montenegro                                \n",
       "7960 Philippines                                                          \n",
       "7961 United States                                                        \n",
       "7962 United States                                                        \n",
       "7963 Hong Kong                                                            \n",
       "7964 United States                                                        \n",
       "7965 Egypt, France                                                        \n",
       "7966 Japan, Canada                                                        \n",
       "7967 Turkey                                                               \n",
       "7968 United States, France, South Korea, Indonesia                        \n",
       "7969 India                                                                \n",
       "7970 India                                                                \n",
       "7971 Pakistan                                                             \n",
       "7972 United Arab Emirates, Jordan                                         \n",
       "7973 United States                                                        \n",
       "7974 United States                                                        \n",
       "7975 United States                                                        \n",
       "7976 India                                                                \n",
       "     type    listed_in                                               \n",
       "1    Movie   Documentaries                                           \n",
       "2    TV Show International TV Shows, TV Dramas, TV Mysteries         \n",
       "3    TV Show International TV Shows, Romantic TV Shows, TV Comedies  \n",
       "4    Movie   Dramas, Independent Movies, International Movies        \n",
       "5    TV Show British TV Shows, Reality TV                            \n",
       "6    Movie   Comedies, Dramas                                        \n",
       "7    Movie   Dramas, International Movies                            \n",
       "8    TV Show TV Comedies, TV Dramas                                  \n",
       "9    TV Show Crime TV Shows, Spanish-Language TV Shows, TV Dramas    \n",
       "10   TV Show International TV Shows, TV Action & Adventure, TV Dramas\n",
       "11   Movie   Comedies, International Movies, Romantic Movies         \n",
       "12   TV Show Docuseries, International TV Shows, Reality TV          \n",
       "13   Movie   Comedies                                                \n",
       "14   Movie   Horror Movies, Sci-Fi & Fantasy                         \n",
       "15   Movie   Thrillers                                               \n",
       "16   TV Show British TV Shows, International TV Shows, TV Comedies   \n",
       "17   TV Show Kids' TV, TV Comedies                                   \n",
       "18   Movie   Action & Adventure, Dramas                              \n",
       "19   TV Show Kids' TV                                                \n",
       "20   TV Show Kids' TV, TV Sci-Fi & Fantasy                           \n",
       "21   Movie   Action & Adventure, Classic Movies, Dramas              \n",
       "22   Movie   Dramas, Horror Movies, Thrillers                        \n",
       "23   Movie   Action & Adventure, Horror Movies, Thrillers            \n",
       "24   Movie   Action & Adventure, Horror Movies, Thrillers            \n",
       "25   Movie   Action & Adventure                                      \n",
       "26   Movie   Dramas, Thrillers                                       \n",
       "27   TV Show International TV Shows, TV Dramas                       \n",
       "28   TV Show International TV Shows, TV Dramas, TV Sci-Fi & Fantasy  \n",
       "29   Movie   Action & Adventure, Anime Features, International Movies\n",
       "30   Movie   Action & Adventure, Anime Features, International Movies\n",
       "⋮    ⋮       ⋮                                                       \n",
       "7947 Movie   Dramas, Independent Movies, International Movies        \n",
       "7948 TV Show International TV Shows, TV Comedies                     \n",
       "7949 Movie   Children & Family Movies, Comedies                      \n",
       "7950 Movie   International Movies, LGBTQ Movies, Romantic Movies     \n",
       "7951 Movie   International Movies, LGBTQ Movies, Romantic Movies     \n",
       "7952 Movie   International Movies, LGBTQ Movies, Romantic Movies     \n",
       "7953 TV Show Anime Series, Kids' TV                                  \n",
       "7954 Movie   Anime Features, Children & Family Movies                \n",
       "7955 Movie   Comedies, Horror Movies, Independent Movies             \n",
       "7956 Movie   Children & Family Movies                                \n",
       "7957 Movie   Children & Family Movies                                \n",
       "7958 Movie   Comedies, Romantic Movies                               \n",
       "7959 Movie   Dramas, International Movies                            \n",
       "7960 Movie   Comedies, Dramas, International Movies                  \n",
       "7961 Movie   Action & Adventure, Comedies                            \n",
       "7962 Movie   Comedies, Dramas, Independent Movies                    \n",
       "7963 Movie   Action & Adventure, International Movies                \n",
       "7964 Movie   Children & Family Movies, Comedies                      \n",
       "7965 Movie   Dramas, Independent Movies, International Movies        \n",
       "7966 TV Show Anime Series, Kids' TV                                  \n",
       "7967 TV Show International TV Shows, TV Dramas                       \n",
       "7968 TV Show Kids' TV                                                \n",
       "7969 Movie   Comedies, Dramas, International Movies                  \n",
       "7970 Movie   Dramas, International Movies                            \n",
       "7971 TV Show International TV Shows, Romantic TV Shows, TV Dramas    \n",
       "7972 Movie   Dramas, International Movies, Thrillers                 \n",
       "7973 Movie   Cult Movies, Dramas, Thrillers                          \n",
       "7974 Movie   Comedies, Horror Movies                                 \n",
       "7975 Movie   Children & Family Movies, Comedies                      \n",
       "7976 Movie   Dramas, International Movies, Music & Musicals          "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "countries\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "0074f598",
   "metadata": {
    "papermill": {
     "duration": 0.059365,
     "end_time": "2022-01-15T23:15:14.949689",
     "exception": false,
     "start_time": "2022-01-15T23:15:14.890324",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### We were able to remove the NA! Unfortunately, \"countries\" and \"listed_in\" have multiple "
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 7.340115,
   "end_time": "2022-01-15T23:15:15.121989",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-01-15T23:15:07.781874",
   "version": "2.3.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
