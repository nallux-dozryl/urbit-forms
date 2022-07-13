<script>
  import { active, submissions, delSubmission } from '../UrbitStore'
  import { statements, subs } from '../Themes/Default/config'

  $: s = 0

    function makeEmptySection(s,n) {
        $submissions[s].data[n] = {sid:n+1,sec:[]}
    }

    function makeEmptyAns(s,n,i) {
      $submissions[s].data[n].sec[i] = {a:[],b:[],c:[]}
    }

    function delSub() {
      delSubmission({id:$active[0].id,rid:$submissions[s].rid})
      $submissions.splice(s, 1)
      submissions.set($submissions)
    }


</script>
{#if $submissions.length < 1}
  <div class="nosub">
    No submissions yet
  </div>
{:else}
  <div class="selector">
    <div class="switch newer">
      <button
       on:click={()=>s == 0 ? s : s--}
        disabled={s == 0}
      >
        🢐 
      </button>
    </div>
    <div class="count">{s+1} of {$submissions.length}</div>
    <div class="switch older">
      <button
        on:click={()=>s < $submissions.length - 1 ? s++ : s}
        disabled={s >= $submissions.length - 1}
      >
      🢒
      </button>
    </div>
  </div>
  <div class="delete">
    <button 
       on:click={delSub}
    >
      Delete
    </button>
  </div>
  <div class="author">~{$submissions[s].author}</div>
  {#each $active[1] as sec, n}
    <div class="section">
      <div class="snum">
        Section {sec.sid}
      </div>
      {#if $submissions[s].data[n] === undefined}
          {makeEmptySection(s,n)}
      {/if}
      <div class="questions">
        {#each sec.sec as q, i}
          <div class="question">
            <div class="qid">{i + 1}</div>
            {#if $submissions[s].data[n].sec[i] === undefined}
              {makeEmptyAns(s,n,i)}
            {/if}
            {#each q.statements as a}
              {#each statements as b}
                {#if b.display === a.display}
                  <svelte:component
                    this={b.component}
                    x={a.x} 
                    y={a.y}
                    z={a.z}
                  />
                {/if}
              {/each}
            {/each}
            {#each subs as c}
              {#if $active[1][n].sec[i].display === c.display}
                <svelte:component
                  this={c.component}
                  info={$submissions[s].data[n].sec[i]}
                  q={$active[1][n].sec[i]}
                 />
                {/if}
            {/each}
          </div>
        {/each}
      </div>
    </div>
  {/each}
  <div class="selector">
    <div class="switch newer">
      <button
       on:click={()=>s == 0 ? s : s--}
        disabled={s == 0}
      >
        🢐 
      </button>
    </div>
    <div class="count">{s+1} of {$submissions.length}</div>
    <div class="switch older">
      <button
        on:click={()=>s < $submissions.length - 1 ? s++ : s}
        disabled={s >= $submissions.length - 1}
      >
      🢒
      </button>
    </div>
  </div>
{/if}

<style>

  .nosub {
    text-align: center;
    font-size: .8em;
    font-weight: 500;
    color: grey;
    margin: 3em;
  }

  .delete {
    text-align: right;
    padding-top: 1em;
  }

  .delete button {
    width: 6em;
    background: none;
    border: solid 1px #f47174;
    color: #f47174;
    padding: .3em;
    font-size: .8em;
    border-radius: 4px;
  }

  .delete button:hover {
    background: #f47174;
    color: white;
  }

  .delete button:active {
    background: red;
    border-color: red;
    color: white;
  }

  .author {
    text-align: center;
    color: grey;
    font-size: .8em;
    font-weight: 600;
  }

  .selector {
    display: flex;
    margin-top: 2em;
    align-items: center;
    border-bottom: solid 1px #e9e9e9;
    padding-bottom: 2em;
  }

  .switch {
    flex: 4;
  }

  .switch button {
    width: 6em;
    background: white;
    border: solid 1px #e9e9e9;
    border-radius: 4px;
    padding: .3em;
  }

  .switch button:hover {
    background: grey;
    color: white;
  }

  .switch button:active {
    background: black;
  }

  .switch button:disabled {
    pointer-events: none;
  }

  .newer {
    width: 6em;
    text-align: right;
  }

  .count {
    flex: 2;
    text-align: center;
    font-size: .8em;
    font-weight: 600;
    color: #191919;
  }

  .snum {
    margin-bottom: 1em;
    text-align: center;
    font-weight: 400;
  }

  .qid {
    font-size: 1em;
    font-weight: 600;
    padding-bottom: .3em;
  }


  .question {
    margin-bottom: 2em;
    padding-bottom: 2em;
    border-bottom: solid 1px #e9e9e9;
  }

  .questions {
    background: white;
    padding: 2em;
    border-radius: 8px;
  }

  .req {
    font-size: .7em;
    color: #666;
    margin: 0 0 .6em 1em;
    font-weight: 600;
  }


  .section-number {
    text-align: center;
    font-size: 1.2em;
    font-weight: 500;
    margin-bottom: 1em;
  }

  .section {
    background: #e9e9e9;
    padding: 2em;
    margin: 2em 0 2em 0;
    border-radius: 8px;

  }

</style>
