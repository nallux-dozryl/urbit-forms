<script>

  import { active, addQuestion } from '../UrbitStore'
  import { page } from '$app/stores';

  export let n

  const url = $page.url;
  let ship;

  let arr = $page.url.pathname.split('/') 

  function makeQuestion(type) {
      let qid = $active[1][n].sec.length + 1

      if (($active[1][n].sec.length > 1) && ($active[1][n].sec[0].qid == 0)) {
          qid = $active[1][n].sec.length
      }

      const data = {
          id: $active[0].id,
          sid: n + 1, 
          qid: qid,
          head: "question",
          display: "text-input",
          accept: "text",
          required: false,
          min: 0,
          max: 0,
          x: [],
          y: [],
          z: [],
          statements: [
            {x: [],y: [],z: [],display: 'title-view'},
            {x: [],y: [],z: [],display: 'essay-view'}
      ]}

     if (type === "text") {
        data["x"] = ['short']
        addQuestion(data)
        delete data.id
        delete data.sid
        $active[1][n].sec.push(data)
        active.set($active)
     }

     if (type === "range") {
        data["display"] = "range-input"
        data["x"] = ['linear']
        addQuestion(data)
        delete data.id
        delete data.sid
        $active[1][n].sec.push(data)
        active.set($active)
     }

     if (type === "one") {
        data["display"] = "one-input"
        data["x"] = ['']
        addQuestion(data)
        delete data.id
        delete data.sid
        $active[1][n].sec.push(data)
        active.set($active)
     }

     if (type === "many") {
        data["display"] = "many-input"
        data["accept"] = "list"
        data["x"] = ['']
        addQuestion(data)
        delete data.id
        delete data.sid
        $active[1][n].sec.push(data)
        active.set($active)
     }

     if (type === "cal") {
        data["display"] = "cal-input"
        data["x"] = ['date']
        addQuestion(data)
        delete data.id
        delete data.sid
        $active[1][n].sec.push(data)
        active.set($active)
     }
  }

</script>

  <div class="add">Add question</div>
  <div class="question">
    <button on:click={()=>makeQuestion("text")}>Text</button>
    <button on:click={()=>makeQuestion("range")}>Range</button>
    <button on:click={()=>makeQuestion("one")}>Multiple choice</button>
    <button on:click={()=>makeQuestion("many")}>Multiple selection</button>
    <button on:click={()=>makeQuestion("cal")}>Calendar</button>
  </div>

<style>

  .add {
    border-top: solid 1px #e9e9e9;
    text-align: center;
    margin-top: 2em;
    padding-top: 2em;
  }

  .question {
    display: flex;
    gap: 1em;
  }

  .question button {
    flex: 1;
    margin-top: 2em;
    padding: 1em;
    border: solid 1px #e9e9e9;
    background: white;
    border-radius: 4px;
  }

  .question button:hover {
    color: white;
    border-color: grey;
    background: grey;
  }

  .question button:active {
    border-color: black;
    background: black;
  }

</style>
