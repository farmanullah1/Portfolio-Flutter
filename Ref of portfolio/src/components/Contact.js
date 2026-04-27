import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { FaGithub, FaLinkedin, FaEnvelope, FaTwitter, FaMapMarkerAlt, FaPaperPlane } from 'react-icons/fa';

const SOCIALS = [
  { href:'mailto:farmanullahansari999@gmail.com',           icon:<FaEnvelope />, label:'Email',    text:'farmanullahansari999@gmail.com' },
  { href:'https://www.linkedin.com/in/farmanullah-ansari',  icon:<FaLinkedin />, label:'LinkedIn', text:'linkedin.com/in/farmanullah-ansari' },
  { href:'https://github.com/farmanullah1',                 icon:<FaGithub />,   label:'GitHub',   text:'github.com/farmanullah1' },
  { href:'https://x.com/farmanullah9088',                   icon:<FaTwitter />,  label:'Twitter',  text:'@farmanullah9088' },
];

const Contact = () => {
  const [form, setForm]     = useState({ name:'', email:'', subject:'', message:'' });
  const [toast, setToast]   = useState(null);
  const [sending, setSending] = useState(false);

  const change = e => setForm({ ...form, [e.target.name]: e.target.value });

  const submit = e => {
    e.preventDefault(); setSending(true);
    setTimeout(() => {
      window.location.href = `mailto:farmanullahansari999@gmail.com?subject=${encodeURIComponent(form.subject||'Portfolio Contact')}&body=${encodeURIComponent(`Name: ${form.name}\nEmail: ${form.email}\n\n${form.message}`)}`;
      setToast('success'); setSending(false);
      setForm({ name:'', email:'', subject:'', message:'' });
      setTimeout(() => setToast(null), 4000);
    }, 600);
  };

  return (
    <motion.section className="contact" id="contact"
      initial={{ opacity:0, y:40 }} whileInView={{ opacity:1, y:0 }} viewport={{ once:true }} transition={{ duration:.6 }}>
      <h2>Get In Touch</h2>
      <p className="contact-subtitle">I'm currently open to new opportunities. Drop a message!</p>

      <div className="contact-layout">
        <motion.div className="contact-info"
          initial={{ opacity:0, x:-30 }} whileInView={{ opacity:1, x:0 }} viewport={{ once:true }} transition={{ delay:.15 }}>
          <div className="contact-info-header">
            <h3>Let's build something amazing together</h3>
            <p>Whether you have a project idea, a job opportunity, or just want to say hello — my inbox is always open.</p>
          </div>
          <div className="contact-socials">
            {SOCIALS.map((s,i) => (
              <motion.a key={i} href={s.href} target={s.href.startsWith('mailto') ? '_self' : '_blank'} rel="noreferrer"
                className="contact-social-row" whileHover={{ x:7 }} transition={{ type:'spring', stiffness:300 }}>
                <span className="contact-social-icon">{s.icon}</span>
                <div>
                  <span className="contact-social-label">{s.label}</span>
                  <span className="contact-social-text">{s.text}</span>
                </div>
              </motion.a>
            ))}
          </div>
          <div className="contact-location"><FaMapMarkerAlt /><span>Sindh, Pakistan — Open to remote worldwide</span></div>
        </motion.div>

        <motion.div className="contact-form-wrap"
          initial={{ opacity:0, x:30 }} whileInView={{ opacity:1, x:0 }} viewport={{ once:true }} transition={{ delay:.2 }}>
          <form className="contact-form" onSubmit={submit}>
            <div className="form-row">
              <div className="form-group">
                <label htmlFor="name">Your Name</label>
                <input id="name" name="name" type="text" placeholder="John Doe" value={form.name} onChange={change} required />
              </div>
              <div className="form-group">
                <label htmlFor="email">Email Address</label>
                <input id="email" name="email" type="email" placeholder="john@example.com" value={form.email} onChange={change} required />
              </div>
            </div>
            <div className="form-group">
              <label htmlFor="subject">Subject</label>
              <input id="subject" name="subject" type="text" placeholder="Project Inquiry / Job Offer / Hello" value={form.subject} onChange={change} />
            </div>
            <div className="form-group">
              <label htmlFor="message">Message</label>
              <textarea id="message" name="message" rows="6" placeholder="Tell me about your project…" value={form.message} onChange={change} required />
            </div>
            <motion.button type="submit" className="btn-primary contact-submit" disabled={sending}
              whileHover={{ scale:1.03 }} whileTap={{ scale:.97 }}>
              {sending ? 'Sending…' : <><FaPaperPlane /> Send Message</>}
            </motion.button>
          </form>
        </motion.div>
      </div>

      <AnimatePresence>
        {toast && (
          <motion.div className={`toast toast--${toast}`}
            initial={{ opacity:0, y:40, scale:.9 }} animate={{ opacity:1, y:0, scale:1 }} exit={{ opacity:0, y:20, scale:.9 }}
            transition={{ type:'spring', stiffness:220, damping:18 }}>
            {toast==='success' ? "✅ Message sent! I'll get back to you soon." : "❌ Something went wrong. Please try again."}
          </motion.div>
        )}
      </AnimatePresence>
    </motion.section>
  );
};
export default Contact;