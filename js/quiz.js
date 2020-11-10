const $content = $(".post-content");
const answerElementToData = el => {
  const $el = $(el);
  const originalText = $el.text();
  const type = $el.find("input[type=checkbox]").length
    ? "checkbox"
    : originalText.startsWith("(")
    ? "radio"
    : null;

  const isCorrect =
    (type == "checkbox" &&
      $(el).find("input[type=checkbox]:checked").length &&
      true) ||
    (type == "radio" && originalText.startsWith("(x)"));

  const text = type == "radio" ? originalText.substr(4) : originalText;

  return { type, isCorrect, text };
};

const quizMarkupToData = () => {
  const $questions = $content.find(".quiz");
  return $questions
    .map((index, element) => {
      const $question = $(element);
      const questionText = $question.text();
      const answers = $question
        .next()
        .find("li")
        .map((i, el) => answerElementToData(el))
        .toArray();
      return {
        questionText,
        answers
      };
    })
    .toArray();
};

const emptyQuiz = () => {
  const $currentQuizElements = $(".quiz");
  $currentQuizElements.first().before("<form class='new-quiz' />");
  $currentQuizElements.next().remove();
  $currentQuizElements.remove();
  return $(".new-quiz");
};

const generateQuestionCardHTML = (question, index) => {
  // console.log(question)
  return `
    <div class="question-card">
      <h5 class="question-number">Question ${index}</h5>
      <h4 class="question-title">${question.questionText}</h4>

        <ul class="question-answers">
          ${question.answers
            .map(
              a => `
            <li class="question-answers-item" data-is-correct="${a.isCorrect}">
              <label class="question-answers-item-fieldset">
                <input name="question ${index}" value="${a.text}" type="${
                a.type
              }" class="question-answers-input"/>
                <span class="question-answers-text">
                ${a.text}
                </span>
              </label>
            </li>
          `
            )
            .join("")}
        </ul>
    </div>
  `;
};

const appendQuestionToQuiz = question => {
  return ``;
};

$(() => {
  const quizData = quizMarkupToData();
  const $newQuiz = emptyQuiz();

  $newQuiz.append(
    `<h4 class="new-quiz-title">Please answer the following questions.</h4>`
  );

  quizData.forEach((question, index) => {
    const questionHTML = generateQuestionCardHTML(question, index);
    $newQuiz.append(questionHTML);
  });

  $newQuiz.append(
    `<div class="quiz-footer">
      <button class="text-btn submit-questions" type="submit">SUBMIT QUESTIONS</button>
      <button class="submit-btn finish-quiz" disabled>FINISH LAB</button>
    </div>`
  );

  $newQuiz.find(".finish-quiz").click(() => {
    $("#congratz-modal").modal();
    //ga('send', 'event', 'Quiz', 'end');
  });

  $newQuiz.submit(e => {
    //ga('send', 'event', 'Quiz', 'start');
    e.preventDefault();
    $newQuiz.addClass("show-answers");
    const dataToSend = $(e.target).serializeArray();

    $newQuiz.find(".finish-quiz").prop("disabled", false);
    $newQuiz.find(".submit-questions").prop("disabled", true);
    $newQuiz.find('input[type="radio"],input[type="checkbox"]').prop("disabled", true);
  });
});
