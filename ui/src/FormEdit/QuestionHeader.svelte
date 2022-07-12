<script>

  import { active, delQuestion } from '../UrbitStore'
  import { page } from '$app/stores';

  export let n, i

  let arr = $page.url.pathname.split('/') 

  function handleDelete() {
      delQuestion(
      arr[3] + "/" + arr[4],
      {
        id: $active[0].id,
        sid: n + 1,
        qid: $active[1][n].sec[i].qid
      })
  }

</script>

<div class="container">
  <div class="num">
  {$active[1][n].sec[i].qid}
  </div>
  <div class="x">
    <button on:click={handleDelete}>x</button>
  </div>
</div>


<style>

  .container {
    display: flex;
    padding-bottom: 1em;
  }

  .x {
    flex: 1;
    text-align: right;
  }

  .x button {
    background: #e6e6e6;
    color: white;
    border: none;
    border-radius: 4px;
    margin-right: -1em;
  }

  .x button:hover {
    background: #ffa1a1;
  }

  .x button:active {
    background: red;
  }

  .num {
    flex: 1;
    display: flex;
    font-size: 2em;
    font-weight: 500;
    margin-left: .5em;
  }

</style>
