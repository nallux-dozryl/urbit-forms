<script>
  import { metas } from '../UrbitStore'

  let cur = Math.round(Date.now() / 1000)

  function makeDate(sec) {
    let date = new Date(sec * 1000)
    let mon = [
      "Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"
    ]
    return mon[date.getMonth()] + " " + date.getDate()
  }
</script>

<div class="title">
  Archived Forms
</div>
{#if $metas}
<div class="forms">
  {#each $metas as form}
    {#if form.status === "archived"}
      <a 
        class="card" 
        href='/apps/forms/~{form.author}/{form.slug}'
      >
        <button>
          <div class="card-title">{form.title}</div>
          <div class="card-author">~{form.author}</div>
          <div class="card-updated">
            {#if (cur - form.updated) <= 60 }
              just now
            {:else if (cur - form.updated) <= 3600 }
              {Math.round((cur - form.updated) / 60)} minutes ago
            {:else if (cur - form.updated) <= 86400}
              {Math.round((cur - form.updated) / 3600)} hours ago
            {:else if (cur - form.updated) <= 259200}
              {Math.round((cur - form.updated) / 86400)} days ago
            {:else}
              {makeDate(form.updated)}
            {/if}
          </div>
        </button>
      </a>
    {/if}
  {/each}
</div>
{/if}
<style>

  .title {
    font-size: 1.1em;
    font-weight: 500;
    padding: .2em 0 1em 0;
  }

  .forms {
    display: flex;
    flex-wrap: wrap;
    gap: .6em;
  }

  a {
    text-decoration: none;
    color: black;
  }

  button {
    width: 100%;
    height: 100%;
    border: none;
    color: inherit;
    background: none;
    text-align: left;
    margin: inherit; 
  }

  .card {
    max-width: calc(25% - .6em);
    flex: 1 0 21%;
    text-align: left;
    height: 5em;
    border: solid 1px #e9e9e9;
    border-radius: 6px;
    background: white;
  }

  .card:hover {
    color: white;
    border: solid 1px grey;
    background: grey;
  }

  .card:active {
    border: solid 1px black;
    color: white;
    background: black;
  }

  .card-title {
    padding: 0 0 .3em .6em;
    font-weight: 500;
  }

  .card-author {
    padding-left: .6em;
    font-size: .8em;
  }

  .card-updated {
    padding-left: .6em;
    font-size: .8em;
  }

</style>
