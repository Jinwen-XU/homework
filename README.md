<!-- Copyright (C) 2023 by Jinwen XU -->

# `homework`, a LaTeX class for writing your homework

## Introduction

The current document class is for writing homework. It has the following features.
- Simple and clear interface.
- Built-in support for many theorem-type environments, already configured and ready to use (in the mean time also very customizable, via `\SetTheorem`), with clever referencing supported.
- Multilingual support: currently supporting Chinese (both simplified and traditional), English, French, German, Italian, Japanese, Portuguese (European and Brazilian), Russian and Spanish.
- Page numbers are of the form `Page [current] of [total]`, which can help you ensure that there are no missing pages when you print your homework for submission.
- Support writing problem statements and solutions (or proofs) in different colors.
- Every statement and solution has its own QED symbol, in hollow or solid shape, respectively.
- You may mark unfinished parts with `\DNF` or `\DNF<⟨remark⟩>` (meaning "did not finish") for reminding — this will give you a clickable report on the unfinished parts at the end of your document.


## Usage

A typical homework document looks like this:

```latex
\documentclass[11pt,
  logo = {image-file-of-your-university-logo}, % Remove this line if you don't want logo presented.
  % logo height = 1cm, % In case you are not satisfied with the default logo size.
  title in boldface,
  title in sffamily,
  theorem in new line,
]{homework}

\UseLanguage{...} % If you wish to write your homework in languages other than English.


\title{The Subject, Week 1}
\author{Author NAME}
\date{\TheDate{2023-12-25}, Location} % or: \date{\today[only-year-month], Location}


\begin{document}


% If you wish to write the answer directly...

\begin{problem}
    Here lies the solution / proof.
\end{problem}


% If you wish to state the problem and then write your answer...

\begin{problem}[You can add some brief problem description here]
    You may also state the problem here...
\end{problem}

\begin{solution}% You may also use the "answer" environment, they are essentially the same.
    ... and write the solution here...
\end{solution}


% If you prefer "Proof" instead of "Solution"...

\begin{solution}[Proof]
    ... or a proof like this one...
    % You may write claims, lemmas, propositions, etc. inside your solution.
    \begin{lemma}\label{lem}
        Some auxiliary result.
    \end{lemma}
    \begin{proof}
        The proof of \cref{lem}, where we use the following formula:
        \[
            \infty = \infty + 1.
            \qedhere % For placing the QED symbol in the right place.
        \]
    \end{proof}
    ... and the rest steps...
\end{solution}


\end{document}
```

> You may refer to the demo documents for more examples.

A few remarks:
1) The logo image can be included via the class option `logo = {⟨image file name⟩}`, and if you are not satisfied with its default size, then you may manually specify the size via the option `logo height = {⟨height⟩}`. If you do not want to show any logo in the title bar, you may simply remove the option `logo = {⟨image file name⟩}`.
1) The options `title in boldface`, `title in sffamily` or even `title in scshape` are for configuring the text effect of the title line, the sectional titles and theorem names.
1) The option `theorem in new line` is for showing the problem / theorem name, numbering and description in a separate line, for the sake of clarity.
1) `\title`, `\author` and `\date` should be placed before `\begin{document}`.
1) Since the problem, solution and other theorem-type environments have a QED symbol at the end, if your text ends with a displayed equation or a `itemize`/`enumerate`/`description` list, then you would need to add a `\qedhere` so that the QED symbol is placed in the right place.
1) Every theorem-type environment has a starred unnumbered version, for instance, `claim*` for unnumbered `claim`, `lemma*` for unnumbered `lemma`, etc.
1) It is recommended to use clever reference, such as `\cref`. For languages such as French and German, to ensure that the generated referencing text is grammatically correct, you may write the definite article and/or declension as optional argument for the referencing commands, for instance, `\cref[à]{⟨label⟩}` or `\cref[de]{⟨label⟩}` for French, `\cref[nom.]{⟨label⟩}` or `\cref[von,dat.]{⟨label⟩}` for German, etc.


## TeXnical details

### Engines and base classes
- With pdfLaTeX, the base class is `minimart`.
- With XeLaTeX or LuaLaTeX, the base class is `einfart`.

### Regarding `\maketitle`

The `\maketitle` has been automatically added just after `\begin{document}`, thus you don't need to write it by yourself. Note, however, that this also means that you cannot place `\title`, `author` and `\date` after `\begin{document}`.

### Regarding the numbering

A new counter named `homework` is defined, which is shared by the environments `problem`, `question` and `exercise`, thus you would see them numbered as `1`, `2`, `3`, etc. The other theorem-type environments are numbered within this counter `homework`, thus within, say, `Problem 1`, you would see them numbered as `Theorem 1.1`, `Lemma 1.2` and `Claim 1.3`, etc.

Therefore, if you wish to manually change the numbering, you may directly access the value of the counter `homework`. Also, each theorem-type environment has its own counter, thus it would still work if you write `\setcounter{exercise}{10}`, but this would also affect the numbering of `problem` and `question`, so don't forget to reset the value as needed.

If you wish them to be numbered separately, you may define new counters, say `problem-counter`, `question-counter` and `exercise-counter` via
```latex
\newcounter{problem-counter}
\newcounter{question-counter}
\newcounter{exercise-counter}
```
and then write this in your preamble:
```latex
\SetTheorem{problem}{shared counter=problem-counter}
\SetTheorem{question}{shared counter=question-counter}
\SetTheorem{exercise}{shared counter=exercise-counter}
```


# License

This work is released under the LaTeX Project Public License, v1.3c or later.
