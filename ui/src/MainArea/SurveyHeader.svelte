<script>
  import { edit, deleteSurvey, editMetadata } from '../UrbitStore'

  export let survey;
  export let admin;

  function handleDelete() {
      deleteSurvey({surveyid: survey[0].id})
  }

  function handleUpdate() {
    const poke = {
      surveyid: survey[0].id,
      title: survey[0].title,
      description: survey[0].description,
      visibility: survey[0].visibility,
      slug: survey[0].slug,
      rlimit: survey[0].rlimit
    }
    editMetadata(poke)
    console.log(poke)
    }

</script>
<div class="container">
  {#if admin}
    <div class="names">
      <input 
        type="text" 
        class=title 
        bind:value={survey[0].title} 
        on:blur={handleUpdate} 
      />
      <input 
        class="description desc-edit" 
        bind:value={survey[0].description}
        on:blur={handleUpdate} 
      />
      <div class="contact">
        ~{survey[0].author}/
        <input type="text"
          bind:value={survey[0].slug} 
          on:blur={handleUpdate} 
        />
        <select 
          on:blur={handleUpdate} 
          bind:value={survey[0].visibility}
        >
          <option value="private">Private</option>
          <option value="public">Public</option>
        </select>
        Response Limit: 
        <input 
          type="number" 
          bind:value={survey[0].rlimit} 
          on:blur={handleUpdate} 
        />
      </div>
    </div>
  {:else}
    <div
      class="trash"
      on:click={handleDelete}
    >
      delete form
    </div>
    {#if survey[0].author === window.ship}
      <div class="vis-badge">
        {survey[0].visibility}
      </div>
    {/if}
    <div class="names">
      <div class=title>{survey[0].title}</div>
      <div class="description">{survey[0].description}</div>
      <div class="contact">~{survey[0].author}/{survey[0].slug}</div>
    </div>
  {/if}
  <div class="panel">
    <div class="tab" on:click={()=> edit.set(false)}>Form</div>
    {#if survey[0].author === window.ship}
    <div class="tab" on:click={()=> edit.set(true)}>Edit</div>
    {/if}
  </div>
</div>
<style>

  .trash {
    text-align: right;
    padding: .6em;
    color: red;
  }

  .trash:hover {
    color: pink;
  }

  .vis-badge {
    color: #ff2c2c;
    border: 1px solid #ff2c2c;
    padding: .2em .6em .2em .3em;
    width: 3em;
    font-size: .8em;
    position: absolute;
  }

  .panel {
    display: flex;
    margin: auto;
    width: 60%;
  }

  .tab {
    flex: 1;
    padding: 1em .3em .3em .3em;
    text-align: center;
  }

  .desc-edit {
    margin-top: .3em;
    width: 80%; 
  }

  .container {
    text-align: center;
    margin-bottom: .6em;
    padding: 0;
    border-bottom: 2px solid black;
  }

  .contact {
    font-size: 0.8em;
  }

  .title {
    font-size: 2.6em; 
    margin-top: .3em;
  }

  .description {
    font-size: 1em;
    margin-bottom: 1em;
  }

</style>
