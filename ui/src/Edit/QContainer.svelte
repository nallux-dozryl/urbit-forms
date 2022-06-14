<script>
  import { frontType, active, editQuestion, delQuestion } from '../UrbitStore'
  import Short from './Questions/Short.svelte'
  import Long from './Questions/Long.svelte'
  import One from './Questions/One.svelte'
  import Many from './Questions/Many.svelte'
  export let qs

    let fronts = frontType
    let data;
    active.subscribe(res => data = res)


    function handleUpdate() {
        const q = data[1][qs.qid - 1]
        const poke = {
          surveyid: data[0].id,
          questionid: qs.qid,
          qtitle: q.qtitle,
          front: q.front,
          back: q.back,
          required: q.required,
          x: q.x,
          y: q.y
        }
      editQuestion(poke)
    }
    function handleDelete() {
      const poke = { surveyid: data[0].id, questionid: qs.qid }
      delQuestion(poke)
    }

</script>

<div class="container">
  <div class=num>
    Question {qs.qid}
    <button on:click={handleDelete}>x</button>
  </div>
  <textarea 
    class="qtitle" 
    bind:value={qs.qtitle} 
    on:blur={handleUpdate}/>
  {#if qs.front === "short"}
    <Short />
  {:else if qs.front === "long"}
    <Long />
  {:else if qs.front === "one"}
    <One on:update={handleUpdate} qs={qs} />
  {:else if qs.front === "many"}
    <Many on:update={handleUpdate} qs={qs} />
  {/if}
  <div class="bottom">
    <div class="required">
      {#if qs.front !== "statement"}
        <input
          bind:checked={qs.required} 
          type="checkbox"
          on:change={handleUpdate}
        />
        <span>required</span>
      {/if}
      </div>
    <select 
      class="front-type" 
      bind:value={qs.front}
      on:change={handleUpdate}
    >
      {#each fronts as front}
        <option value={front[1]}>{front[1]}</option>
      {/each}
    </select>
  </div>
</div>

<style>

  button {
    float: right;
    border: none;
    background: none;
    color: red;
  }

  button:hover {
    color: pink;
  }

  .bottom {
    display: flex;
    padding: .6em 1em .6em 1em;
  }

  .required {
    flex: 2;
    font-size: 0.8em;
  }

  textarea {
    width: 100%;
  }

  .container {
    margin: auto;
    max-width: 80%;
    border-bottom: 1px solid black;
  }

  .num {
    margin: auto;
    text-align: center;
    border-bottom: 1px solid black;
    padding: 4px;
  }

</style>
